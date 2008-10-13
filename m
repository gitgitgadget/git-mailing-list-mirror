From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix git-pull/git-merge --quiet and --verbose
Date: Mon, 13 Oct 2008 23:12:18 +0200
Message-ID: <4ac8254d0810131412o34c01a4cla30eadc45e2e4e06@mail.gmail.com>
References: <4ac8254d0810120954x2364054ahf2d49d6fbb7b0bb1@mail.gmail.com>
	 <20081012200833.GC5255@spearce.org>
	 <4ac8254d0810121431v1a67afc8ua92842b3d8c39328@mail.gmail.com>
	 <4ac8254d0810121436x6285d17ew631f04e768a6fb62@mail.gmail.com>
	 <4ac8254d0810131403i4c8c57d6r71531e34321e9b50@mail.gmail.com>
	 <20081013210607.GV4856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:13:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpUjM-0002jf-GZ
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 23:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751AbYJMVMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 17:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755856AbYJMVMU
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 17:12:20 -0400
Received: from rn-out-0910.google.com ([64.233.170.189]:25937 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057AbYJMVMT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 17:12:19 -0400
Received: by rn-out-0910.google.com with SMTP id k40so901709rnd.17
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 14:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=X5TbQoeGe+ANg2sDdNW52xglHODIEPPi41uR9hBIvVs=;
        b=v5Ui+Ssd19QG4hRMNML8JB496uByqBAqEcttHUnzwYA19HXncuauXRPZtrSbuIP4fF
         rIpc7HvjrBeiDFjYxlJ6vKITrTCknEtiz5Flm9RDLYQkL1CTMcuLhBQHivs9c3gu1iYX
         NUlcxv6O6DPstmGNkPExXKcNQLmQ5a+YOV0Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LJcrk7ElIYWfuJ1RxBfSRcAdRDyqzQClKbsPnrXVcOxbCk1asb5kSjGnZNIHAhqRwc
         j105LqEFDt/V1cCHZ8POTEEuJBj6e4W4GGwWi8Z2CrTVpEaOBS4YYE9T8Qr+kx+S0vqE
         55sJwS5nUlgfI8P/FaLlhF4MkaXBHpTH2jX4s=
Received: by 10.65.218.13 with SMTP id v13mr11519110qbq.49.1223932338089;
        Mon, 13 Oct 2008 14:12:18 -0700 (PDT)
Received: by 10.64.142.13 with HTTP; Mon, 13 Oct 2008 14:12:18 -0700 (PDT)
In-Reply-To: <20081013210607.GV4856@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98156>

On Mon, Oct 13, 2008 at 11:06 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
>> Hi Shawn and list,
>>
>> I've updated the patch to current Junio master.
>>
>> Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
>
> Looks good to me.

GMail borked it by inserting some linebreaks :(
is that a problem for this single diff or should
I first resend it properly via SMTP?
