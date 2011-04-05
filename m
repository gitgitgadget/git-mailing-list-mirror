From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: rebase autosquash doesn't recognise a chain of fixups
Date: Tue, 05 Apr 2011 17:48:59 +0200
Message-ID: <4D9B39EB.9040208@lyx.org>
References: <20110405154100.GC16031@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Apr 05 17:49:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q78VF-0003Cb-BI
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 17:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab1DEPtI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 11:49:08 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:48751 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1DEPtG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 11:49:06 -0400
Received: by wwk4 with SMTP id 4so2900140wwk.1
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 08:49:04 -0700 (PDT)
Received: by 10.227.195.129 with SMTP id ec1mr8487232wbb.180.1302018544279;
        Tue, 05 Apr 2011 08:49:04 -0700 (PDT)
Received: from [192.168.182.247] (106.244.93.77.dsl.static.ip.kpnqwest.it [77.93.244.106])
        by mx.google.com with ESMTPS id l24sm3647655wbc.30.2011.04.05.08.49.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 08:49:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110405154100.GC16031@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170884>

On 5-4-2011 17:41, Carlos Mart=EDn Nieto wrote:
> Hello,
>
>   Say I have the following commits:
>
>      5154127 fixup! fixup! one
>      0d130d8 fixup! one
>      0869d30 one
>
> because I keep executing `git commit -a --fixup HEAD`.
>
> Am I just too lazy and should look up the commit I want to fixup?

I would use 'git commit --amend -a' instead if I am already sure that I=
=20
want to squash my commit into the previous one.

Vincent
