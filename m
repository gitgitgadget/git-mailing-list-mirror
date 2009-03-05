From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git-svn and repository hierarchy?
Date: Thu, 5 Mar 2009 14:48:14 -0500
Message-ID: <eaa105840903051148s3515e8b7x9d7b8f9be12da735@mail.gmail.com>
References: <20090227171248.GB14187@raven.wolf.lan>
	 <20090227220512.GC14187@raven.wolf.lan>
	 <49A97B7A.8010005@drmicha.warpmail.net>
	 <20090303185108.GA11278@raven.wolf.lan>
	 <eaa105840903031135o4cf72ed0oe3fffed69cb7ce03@mail.gmail.com>
	 <20090303223600.GB11278@raven.wolf.lan>
	 <eaa105840903031618s5e0b6f24j64aade8d752fb11@mail.gmail.com>
	 <20090304192752.GC11278@raven.wolf.lan>
	 <eaa105840903041406k36088763w5a70fe1d7458dfb1@mail.gmail.com>
	 <20090305180529.GD11278@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 20:49:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfJZk-0007Tz-ST
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 20:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbZCETsS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 14:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754756AbZCETsS
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 14:48:18 -0500
Received: from el-out-1112.google.com ([209.85.162.180]:50048 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370AbZCETsR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 14:48:17 -0500
Received: by el-out-1112.google.com with SMTP id b25so82096elf.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 11:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=HJvgKCKC+ITdQSdWa2KvETct48DmSpPQN81Xm3w2tds=;
        b=loX/LE1nO9UFbAyIU+tbXlb4KRZeEOMGw+ZnAEyaug66VArCIqZo6qixzxkQnVL7Um
         KU2EafaUhTPOuZDB7oLW7oz2y7E3dnqYD9fyI5UVyd+UntAMfUpxb5wInyqRkZ7ZTJn9
         3rbZHMq2IapZS8crNl1EMHWouFcspX4fUCtjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ME+XTe1M2rm7MXY6nhBw7D2IRlejusIidDmbHGKEWmZ1JR5y1qn0mqNUKoOpdB+G6V
         DFxK8gJMqATIEXmjg03mna5WbqBLqgBieZeF+ox9FkEzylo3W1bL9wVgpcmGVWy4aHuk
         9cKc2Est0WC++0wzcOCoSsiRdBU5ZBTKYBKOg=
Received: by 10.220.95.75 with SMTP id c11mr588753vcn.1.1236282494334; Thu, 05 
	Mar 2009 11:48:14 -0800 (PST)
In-Reply-To: <20090305180529.GD11278@raven.wolf.lan>
X-Google-Sender-Auth: f04a2e31f704c850
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112329>

On Thu, Mar 5, 2009 at 1:05 PM, Josef Wolf wrote:
> On Wed, Mar 04, 2009 at 05:06:06PM -0500, Peter Harris wrote:
>>
>> I thought that this was already a part of svn, but it appears in the
>> 1.6 (not quite final yet) release notes: "SSL client certificate
>> passphrases can be stored in KWallet, GNOME Keyring, Mac OS Keychain=
,
>> a Windows CryptoAPI encrypted form or in plaintext form."
>
> Ummm, I always found it hard to find their changelog. =A0At least
> http://svn.collab.net/viewvc/svn/trunk/CHANGES?view=3Dmarkup&pathrev=3D=
36138
> don't mention those features. =A0Do you have a pointer?

http://subversion.tigris.org/svn_1.6_releasenotes.html#auth-related-imp=
rovements

>> Of course, you're a paranoid admin, so you already have a
>> pre-revprop-change hook in your svn server that prevents
>> log/author/date changes. Right? ;-)
>
> Well, actually it allows the changes for a very limited user group (t=
hat
> is: only me 8-). =A0While I agree that author/date should not be chan=
ged,
> I like to be able to fix silly typos in the log. =A0After all, we all=
 do
> typos now and then ;-)

True, but in my experience it happens considerably less often with
git. I find and fix most of my typos when reviewing my change-set
before doing a "git push" or "git svn dcommit".

> Maybe there's room for more improvement: =A0Since the merge is done o=
n a
> scratch branch anyway, why not letting the clones _push_ into branche=
s
> with random names: cloneX-`uuidgen` or something. =A0So the clones co=
uld
> do the push whenever they have net access. =A0The actual merge can be=
 done
> completely decoupled from the push operation.

Indeed. Or even not-so-random names, such as cloneX/topic-name if you p=
refer.

Peter Harris
