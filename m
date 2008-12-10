From: "Brett Simmers" <swtaarrs@gmail.com>
Subject: Re: after first git clone of linux kernel repository there are changed files in working dir
Date: Wed, 10 Dec 2008 15:20:16 -0500
Message-ID: <e32b7bb40812101220s370a64f1n3f7ecb56dd352405@mail.gmail.com>
References: <d304880b0812101019ufe85095h46ff0fe00d32bbd0@mail.gmail.com>
	 <d304880b0812101022u2abe5d68ub3bda68ed39f830b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: rdkrsr <rdkrsr@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 21:21:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAVYx-0003Mu-Kf
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 21:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755848AbYLJUUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 15:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755826AbYLJUUS
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 15:20:18 -0500
Received: from wf-out-1314.google.com ([209.85.200.169]:50956 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbYLJUUR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 15:20:17 -0500
Received: by wf-out-1314.google.com with SMTP id 27so330943wfd.4
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 12:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KKFqOo30R8ETrZ3U384Zcftbn//PZhsneU19tUCDXic=;
        b=v9d8eXeaVms5468DLMgBy61SbhaYT+w6ZAqVRWvxSyN/Pnt+5kK6xRvifupKHxicQG
         bttgMmmkJZokQFjDbSDw5WJPFSEx7d+25Rz2l7ZxFWdCumbCKiDmHMCNM8RVRzbG1d+y
         wgqYmj6ng2Kd8ZdRBvL6O4OVS3zh8JTw3vaGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PVoyMfsqqEpt5gjH3q/HuM61arW2tmutYOTf8ll61aibvhDydwyIwbvBeuiaDZcRKl
         LXRNf/fzWXu+9cx8iFHlGaZinEMPzcoRgajMI6CZxLRN8X067n0H3atX26dGbrVS/cTu
         FQZZ7p3VmiskRk04FQ5vxMBELeoLHoPUNbawk=
Received: by 10.142.14.20 with SMTP id 20mr367054wfn.322.1228940416540;
        Wed, 10 Dec 2008 12:20:16 -0800 (PST)
Received: by 10.143.30.7 with HTTP; Wed, 10 Dec 2008 12:20:16 -0800 (PST)
In-Reply-To: <d304880b0812101022u2abe5d68ub3bda68ed39f830b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102715>

On Wed, Dec 10, 2008 at 1:22 PM, rdkrsr <rdkrsr@googlemail.com> wrote:
> I just fetched the sources without changing anything, but git diff
> shows, that there are changes that are not yet updated (changed but not
> updated: use git add to ...). Why is it like that?
>
> I use msysgit on windows, maybe that is one reason?

What are the filenames? I've seen git on Windows get confused if a
repository has two files that are the same except for the case of some
of the letters (since both can't exist by default on NTFS).

-Brett
