From: =?windows-1252?Q?S=E9bastien_Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH v2 2/3] git help: group common commands by theme
Date: Sat, 02 May 2015 13:52:35 +0200
Message-ID: <5544BA83.6000506@gmail.com>
References: <554405D5.9080702@gmail.com> <554406FC.8010309@gmail.com>	<CAE5ih78xxHj-YZVnNB=kNw5ZOkT1t2dcc5yjiUWemEQpwFQfDw@mail.gmail.com> <87wq0rb3xk.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>,
	Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat May 02 13:52:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoVyU-0003dw-Qt
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 13:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbbEBLwj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2015 07:52:39 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35441 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbbEBLwi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 07:52:38 -0400
Received: by widdi4 with SMTP id di4so75931917wid.0
        for <git@vger.kernel.org>; Sat, 02 May 2015 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=rhbzEUvXGFhXjs6qdmrYhjDZEQLPIJsqaBxlSAbKcf8=;
        b=E1mXwIBhzq84amhb1WAxDOZZCD0r70LRxZDVkYIwIFoZSiB/NnYRUjY31UAe27ue5p
         nNyW4nKPaJTEkV3tpthrTvGZbY8WYvWLTMSWWnWbYCr5qrP/zzKjWZgM7fNeZ0tD1SLV
         Y3X+3TfcKIU4NAs1YuZ0r7nnB9FRmYnoaWeiYopwcKSPV8KisLsI2ettnIGQayfOAKmn
         OIKTPUTF2GNBVzqp6bwM6VpDxAmt8+/QdoHT7AH8oBNEU7fDCfvyryHuLqyHxX91kb7h
         Aj6uoOpMHdHryK27YMvr2uq45en7Xw4dSPgkaSOsykz3ANxJzZ1Iw1sd2CXAPZQyQ1X4
         YjVA==
X-Received: by 10.180.106.131 with SMTP id gu3mr4471267wib.16.1430567557193;
        Sat, 02 May 2015 04:52:37 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id fo7sm2103757wic.1.2015.05.02.04.52.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 May 2015 04:52:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <87wq0rb3xk.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268228>

On 05/02/2015 01:43 PM, Andreas Schwab wrote:
>  or:
>
>    sort |
>    while IFS=3D: read cmd grp
>    do
>
>  Andreas.

I believe this is the most legible form, the intention is much clearer.

S=E9bastien
