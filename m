From: Timur Tabi <timur@freescale.com>
Subject: Re: How does format-patch determine the filename of the patch?
Date: Thu, 29 Oct 2009 08:05:21 -0500
Message-ID: <ed82fe3e0910290605j302747f9o6a86acb414427639@mail.gmail.com>
References: <ed82fe3e0910150917u72ef189epc74411e71a9cd2d4@mail.gmail.com>
	 <200910151959.47778.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 14:05:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Uh0-0007Ov-3J
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 14:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbZJ2NFT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Oct 2009 09:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752899AbZJ2NFT
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 09:05:19 -0400
Received: from gv-out-0910.google.com ([216.239.58.191]:42913 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbZJ2NFR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2009 09:05:17 -0400
Received: by gv-out-0910.google.com with SMTP id r4so246649gve.37
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 06:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=6sWwtROAtSkx9/qqpRAuDJ1H12lIdCz4i2OWNNJCx54=;
        b=l1/W9owJOrh6pCjFIurYr9zV3giMyt2WHagP+6UTKsmMCTM/m1NBeV7YwNVqzqy9j+
         ymuk/q79VJsk51Y8c/jm5uoFxoJttRnr59eEmAfwcrXtBCDBEirj6nR9ypk+bFJxGUOl
         KIk+roBV/qVjio8PK46O4UPlACnyrZwF73V/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Mp+7R+zuYDpQh1CleYun2UrLGF3hkewwVIzpM7PZ9pkQGPNICHltQX2FFe3/8RpskP
         rAnwRLp95/w1xznVtIWsjOb5Eg/xv6DsvPDuZPEJv4EnPQg6cFdYJfdscojg+VgDQD9S
         J78I7huLTt9Zu3dFKUVvpfG0QT8V2zXDJactY=
Received: by 10.239.168.138 with SMTP id k10mr1597hbe.100.1256821521714; Thu, 
	29 Oct 2009 06:05:21 -0700 (PDT)
In-Reply-To: <200910151959.47778.robin.rosenberg.lists@dewire.com>
X-Google-Sender-Auth: 72fdc951929eeb29
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131589>

On Thu, Oct 15, 2009 at 12:59 PM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:

>> The reason I ask is that I'm writing a script which calls
>> git-format-patch to create some patches for post-processing. =A0So I
>> need the name of the file that git-format-patch creates so that I ca=
n
>> open it and examine it. =A0I'd liked to see if there's a way to get =
the
>> name of the patch without actually creating the file.
>
> It tells you the names on stdout.

Is there a way for it to tell me the name on stdout *without* actually
creating the patch?

--=20
Timur Tabi
Linux kernel developer at Freescale
