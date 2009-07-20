From: Rustom Mody <rustompmody@gmail.com>
Subject: how to reorder commits
Date: Mon, 20 Jul 2009 20:37:50 +0530
Message-ID: <f46c52560907200807heed4bbfkde15cccd2ae8151d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 17:14:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSuZc-0006NG-JG
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 17:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbZGTPOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 11:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbZGTPOe
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 11:14:34 -0400
Received: from mail-px0-f193.google.com ([209.85.216.193]:38787 "EHLO
	mail-px0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbZGTPOe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 11:14:34 -0400
Received: by pxi31 with SMTP id 31so435500pxi.33
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=ZlYMxNbQT6yxLyHZ7W6w+sYgA4gwk+Uan7vn5MxLKgU=;
        b=q4O7QrMw8IvYJgmeZEEy0n0j6Ys3zVoV7drudMoWHQNb2kG9cQ7AezypD+NFpxavtg
         edSVjslaX15ncRYCXjnk/EdBi7nvG629y35WeADhwe8z2W/Pl5aUbQEON/UT3mgZhidY
         WHYFVDNsckwb1Oiu+2QoXbS3hFBacW7L8JuJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=lBSfcoTJhXYeiY3t0/NlZd5lE/W7K0LGFKrFR6Ar/993eDtzEKJvHpmMiVfSfj7vrt
         6iqm5dsM9DxEXpiXXRGK2EPyfLeflTNVHbPfdI9Wba7Z+9k3C8+vWe2AGcWeAvU8ZtLY
         1ePNJMTIEEm41AJRyDfVMnAsUnZxHtG0UHx48=
Received: by 10.114.147.1 with SMTP id u1mr7335789wad.108.1248102471058; Mon, 
	20 Jul 2009 08:07:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123608>

I have a sequence of commits. I tried to reorder the top two in this way.
$ git rebase -i HEAD^^

flip the two pick lines and exit vi

I find my file full of conflict markers.
So what is the way of doing:
HEAD becomes current HEAD^
HEAD^ becomes current HEAD
without having to handle conflicts ??
