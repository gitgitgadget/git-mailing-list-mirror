From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] Make generated MSVC solution file open from Windows 
	Explorer
Date: Sat, 26 Sep 2009 00:41:01 +0200
Message-ID: <bdca99240909251541h2e9932a3r67c1d8604e56a8df@mail.gmail.com>
References: <4ABB84F4.7080403@gmail.com> <20090925220510.GY14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mstormo@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 26 00:41:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrJTQ-0006n7-JW
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 00:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbZIYWk7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Sep 2009 18:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257AbZIYWk7
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 18:40:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:43268 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbZIYWk6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Sep 2009 18:40:58 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1017423fge.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 15:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NRd1xySGXMgU36XuuAAk12XFklyntpUlfHIQtXcr04Q=;
        b=vuYX3rb8b+6dvDIVFshpvZKAsQy3qLXqPY2+IE431AG3KmYGHrfNnnzJDjswhBBYEs
         RDIIuk7zcdUlNjW2btvpbj5DsKFj8p/fq4oiZqlcx3tap3law20tJQixGQyjlmB/L9za
         2ouiWoaSRvU2QCRTyYW5Hr3cQzyMeY0iUHf0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PyKdS6TTMqvdFs+WSD5xKK4e+y38vjJfSX3rP8wU+jZNrtq6jweY8kfoxpE/G5JwIp
         zh5eoV+s4ZiQzcWA4+1KIbOqR3XuGC6kPKBE+SB+aB5dm5Lq9xY7aHG+NlKRMbYEt6ZX
         lQu+961dj/Vy6qCiQLpDTyHjTxqmYiVOtj9fw=
Received: by 10.86.227.26 with SMTP id z26mr1358682fgg.76.1253918461305; Fri, 
	25 Sep 2009 15:41:01 -0700 (PDT)
In-Reply-To: <20090925220510.GY14660@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129128>

On Sat, Sep 26, 2009 at 00:05, Shawn O. Pearce <spearce@spearce.org> wr=
ote:

> Sebastian Schuberth <sschuberth@gmail.com> wrote:
>> From c6d29a2d243647bb2877eb2114938ae20c8e56e5 Mon Sep 17 00:00:00 20=
01
>> From: Sebastian Schuberth <sschuberth@gmail.com>
>> Date: Thu, 24 Sep 2009 15:52:25 +0200
>> Subject: [PATCH 1/2] Make generated MSVC solution file open from Win=
dows Explorer
>>
>> In order to be able to open the generated solution file by double-cl=
icking it
>> in Windows Explorer, all project files need to use DOS line-endings =
and a
>> comment about the Visual Studio version needs to be added to the hea=
der of the
>> solution file. This also fixes the icon that is displayed for the so=
lution file
>> in Windows Explorer.
>> Note that opening the solution file from a running instance of Visua=
l Studio
>> already worked before.
>
> Something is wrong with both patches; neither applies. =C2=A0It looks
> to be an issue with whitespace, like context lines are gaining an
> extra space at the start of the line.

Hmm, the patches apply fine onto master for me.

As a side note, I've never liked sending patches via mail. It just
feels like writing a text on a computer just to print it out, scan in
the sheet again, and then sending the scanned image as an attachment
via email. Isn't there a better way to contribute patches to Git, like
pushing to a mob branch as for the msysGit project?

--=20
Sebastian Schuberth
