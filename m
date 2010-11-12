From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv7 00/11] gitweb: remote_heads feature
Date: Fri, 12 Nov 2010 09:05:59 +0100
Message-ID: <AANLkTimbnwi8B3YtOgxe=qATxOA+baGe=igAa2qQ1e30@mail.gmail.com>
References: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com> <201011112029.22373.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 09:06:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGoee-0004Ei-8P
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 09:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab0KLIGU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Nov 2010 03:06:20 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46714 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab0KLIGU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Nov 2010 03:06:20 -0500
Received: by iwn10 with SMTP id 10so3196201iwn.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 00:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=S4SuoBrJcYGKzSIkKz/6tkQ8EDBCrOBDCsW5/bZbZU4=;
        b=MXhDnHY06sjHko0PLR8jvyVWd0TlfFU/5YyMaLYSWjiqJ3V0sRVcraa2Zay6IWAEBK
         O4RQBuq5npe68FdRkT/rF5K7LM/tFksIorHZPqfl5N1mqqmmu0qA28disWYEgzbc3uqB
         EjCbxUavgtu1E5n4pf4+BqbqGW7NYUNUsgsmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ExQ7XB0JYgukyn/X5EXSLyWV97fN7E7edPGbSiceg6UgnjTPW0VeyRM6uCUuuISlQ0
         QuRHKJVz1TqD54cI+SOUjT7Ol4jBFUs9WOkjK82cFAcI8WwRb9jIuc7SZMgjcoeJ6I94
         Oi+e5Lp6CWIgY1H6MwFqcjZ5ktlx74thtLhvw=
Received: by 10.231.153.69 with SMTP id j5mr1641660ibw.7.1289549179225; Fri,
 12 Nov 2010 00:06:19 -0800 (PST)
Received: by 10.231.160.210 with HTTP; Fri, 12 Nov 2010 00:05:59 -0800 (PST)
In-Reply-To: <201011112029.22373.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161328>

2010/11/11 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 11 Nov 2010, Giuseppe Bilotta wrote:
>
>> This 7th version of the remote heads feature for gitweb differs from=
 the
>> previous mostly my small tune-ups, renames of internal functions, so=
me
>> patch reordering and a final addition.
> [...]
>
> I like this version very much.

Thanks.

>> Giuseppe Bilotta (11):
>> =A0 gitweb: use fullname as hash_base in heads link
>> =A0 gitweb: introduce remote_heads feature
>> =A0 gitweb: git_get_heads_list accepts an optional list of refs
>> =A0 gitweb: separate heads and remotes lists
>> =A0 gitweb: nagivation menu for tags, heads and remotes
>> =A0 gitweb: allow action specialization in page header
>> =A0 gitweb: remotes view for a single remote
>> =A0 gitweb: refactor repository URL printing
>> =A0 gitweb: provide a routine to display (sub)sections
>> =A0 gitweb: group remote heads by remote
>> =A0 git instaweb: enable remote_heads
>
> With exception of next to last patch, which contains a few of outdate=
d
> comments (see my response for this commit), I don't see any problems.

I will send a -bis for that patch, with the amended comments.

> So, for the whole series:
>
> =A0Acked-by: Jakub Narebski <jnareb@gmail.com>
>
>
> Thanks for working diligently on this series, Giuseppe!

Thank _you_ for the thorough review!

--=20
Giuseppe "Oblomov" Bilotta
