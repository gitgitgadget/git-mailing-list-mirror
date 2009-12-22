From: B Smith-Mannschott <bsmith.occs@gmail.com>
Subject: Re: Huge pack file from small unpacked objects
Date: Tue, 22 Dec 2009 09:54:40 +0100
Message-ID: <28c656e20912220054qc7b6497t79e135c913865c22@mail.gmail.com>
References: <404585ED79625A40AB5A9884ECA9A63B3E02083F@VMBX125.ihostexchange.net>
	 <75B8C0BEE0AE2A44AA971D218D9FE99E3DD8C61C@VMBX125.ihostexchange.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Triantos <nick@perceptivepixel.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 09:54:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN0W0-0005Qf-Hm
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 09:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbZLVIyn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Dec 2009 03:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbZLVIyn
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 03:54:43 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:60392 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbZLVIym convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 03:54:42 -0500
Received: by ewy19 with SMTP id 19so5020365ewy.21
        for <git@vger.kernel.org>; Tue, 22 Dec 2009 00:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xwagDCk63tz44xi9sWzGqHl6E74gvThCdx5+vmVXUFY=;
        b=Isnh39xcu7WzwQ4C4f/bosSNyVzoewwWvyWGNBXDhQZHRgzbwWf9EgonUG6muW78Kj
         jIu30dOOTw0h/z0l19fSrDMJt1Wmpch3pYJQStBDRJDz0KuqJk7OqAlNIzfzwMcRPlGV
         AAAm9iDal3PkqfqQKObcJhKLfeK3139gpcVuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xn2zlmlPUhp88XBEeXcXIbnzxUk8yJbdD/zWq6BqpSBQtTKQZurNdV8pj5wN2r4cp1
         xs56Wj8w6Z1YxV5iQpAMxtNDKJteWcyAQOD8U5YNQX16T2cfkP/qu+nX0Tlmor4u17kF
         3C9RfWrvkNBINs1aR5rLLWpWwqvgRSHsqKxO4=
Received: by 10.213.0.144 with SMTP id 16mr9837134ebb.38.1261472080275; Tue, 
	22 Dec 2009 00:54:40 -0800 (PST)
In-Reply-To: <75B8C0BEE0AE2A44AA971D218D9FE99E3DD8C61C@VMBX125.ihostexchange.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135575>

On Wed, Dec 16, 2009 at 17:34, Nick Triantos <nick@perceptivepixel.com>=
 wrote:
> Hi,
>
> I recently created a repo from SVN via git-svn.=C2=A0 The bare repo w=
as about ~600MB.=C2=A0 I cloned it, and on the clone, I added 2 small f=
iles (.gitignore and .gitattributes) to a branch, merged them to master=
, and pushed that back to the origin.=C2=A0 The cloned repo remains at =
about 600MB, while my origin repo (the one from svn) is now about 2.4GB=
=2E=C2=A0 I found that it created a file in objects/pack which accounts=
 for this huge size.
>
> I've tried running 'git repack -a -d' but that didn't shrink the size=
 of this pack file.
>
> Any ideas why the pack file is so huge?=C2=A0 Anything I can do to sh=
rink it?=C2=A0 My coworkers are understandably unhappy that the repo is=
 so huge now (makes for very slow pulls)

Have you tried "git prune"?

// Ben
