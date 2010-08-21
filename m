From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [feature request] gitweb: tags in history
Date: Sat, 21 Aug 2010 12:17:40 +0200
Message-ID: <201008211217.41859.jnareb@gmail.com>
References: <20100821092616.5e57135b@hyperion.delvare> <m3wrrknzph.fsf@localhost.localdomain> <20100821111555.11879d02@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Jean Delvare <khali@linux-fr.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 12:18:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oml9P-0001Mw-Lm
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 12:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459Ab0HUKRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 06:17:55 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41730 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab0HUKRx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 06:17:53 -0400
Received: by bwz11 with SMTP id 11so2730686bwz.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=j5eWW6D+DMlB2xcR/Y01ly/6QHQ6qJj53B5zEFaX6U0=;
        b=SExIBuUHTwpCuAkBpChK7ugGZvzcDq04LG5yIkthOISJaxbOxkIma9cIX4LIgHml96
         wFeyN6/hmESrYazcYLJGG5MOoKHabL5vvNeY0yo9Odb+1+x/r7YkDQi80gBuhZsHFKmX
         fyVzcQXWiCFuWx+GUAK8Rkdi4iB0mkaFqlWY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HgZcMx6fN3Qbt8RK/Vw12Zxwcel8mzNcrpzxLh91aUmdAU/kik5I4mnm7jMZeRJhn/
         eXy6XtMpJNVKoCE46FA1II5r91miRiDKCOdL1dLQ43SdL5UO3le36t8UznDu3nRo5CcA
         +pRruHk4QVRcfx2IGnExYHmzzu4YYPZdjDAgU=
Received: by 10.204.73.130 with SMTP id q2mr1761427bkj.137.1282385872419;
        Sat, 21 Aug 2010 03:17:52 -0700 (PDT)
Received: from [192.168.1.13] (aeho172.neoplus.adsl.tpnet.pl [79.186.196.172])
        by mx.google.com with ESMTPS id x19sm2801277bkv.21.2010.08.21.03.17.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 03:17:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100821111555.11879d02@hyperion.delvare>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154135>

On Sat, 21 Aug 2010, Jean Delvare wrote:
> On Sat, 21 Aug 2010 01:22:05 -0700 (PDT), Jakub Narebski wrote:
>> Jean Delvare <khali@linux-fr.org> writes:
>> 
>>> I have a feature request for gitweb. In the history view, I would like
                                                ^^^^^^^
                                                    |
I'm very sorry, somehow I didn't notice this part --/

>>> to be (optionally) able to see the tags, interlaced with the actual
>>> commits. The idea is to get an immediate view of all commits that
>>> happened between specific tags.
>>> 
>>> The actual format for displaying the tags can certainly be discussed, I
>>> have no strong opinion on this myself. We may want to let the admin
>>> filter which tags should show up that way, maybe even letting him/her
>>> define primary and secondary tag formats (think main releases vs.
>>> release candidates) for nicer output. Then we may want to group (or
>>> hide) tags when a file hasn't been modified in a long time. But these
>>> are implementation details, even the raw functionality would be quite
>>> useful IMHO, and hopefully not too difficult to implement.
>> 
>> Currently in 'shortlog' view you can see 'ref' markers... which
>> include tags.
>> 
>> For example 'shortlog' view for 'maint' branch has the following
>> fragment:
>> 
>>  2010-07-28 	 Matthieu Moy	 Document ls-files -t as semi-obsolete.
>>  2010-07-27 	 Junio C Hamano	 Git 1.7.2.1  [v1.7.2.1]
>>  2010-07-27 	 Junio C Hamano	 Sync with 1.7.1.2
>>  2010-07-27 	 Junio C Hamano	 Git 1.7.1.2  [v1.7.1.2]
>>  2010-07-27 	 Junio C Hamano	 Sync with 1.7.0 series
>>  2010-07-27 	 Junio C Hamano	 Git 1.7.0.7  [v1.7.0.7]
>> 
>> where e.g. [v1.7.2.1] is ref marker for 'v1.7.2.1' tag.
>> 
>> If you have something different in mind, please provide moackup,
>> either as ASCII-art, or link to HTML or image.
> 
> Yes, visually this would be very fine with me.
> 
> But shortlog is a repository-wide view, while I need the same for
> history which is a file-specific view. Things are obviously a little
> more complex there, because for a given file, it is statistically
> unlikely that each commit affecting the file in question corresponds to
> a tag.

At least in git repository the 'Git X.Y.Z' commit, which is tagged with
vX.Y.Z signed tag, touches only Documentation/RelNotes-X.Y.Z (and
changes Documentation/RelNotes symlink to point to it, if needed),
changes DEF_VER in GIT-VERSION-GEN (fallback version), and updates
Documentation/git.txt (for example adding link to newest RelNotes).

So it is very unlikely that for a given file there would be any tag
that points to commit in history of a file.

> So we have to find the best tag to display in front of 
> each commit (easiest bet would be the next tag time-wise) and maybe
> improve a bit from there (for example by not showing the same tag
> twice). But then again I would be very happy with a relatively raw
> output for the time being.

It would be unfortunately more costly than ref markers in 'shortlog'
and 'log' views, because it is not enough to get all refs and use
reverse mapping (from commit to the tag that points to it).  There
is decorate / name-rev, but it creates some performance cost.

So it wouldn't be easy to create a UI for this (ref markers are not
good, as they are meant to point directly to commit, not as 'tag
pagination'), and it wouldn't be very easy to get data that is needed
for that.

But this should be possible...
-- 
Jakub Narebski
Poland
