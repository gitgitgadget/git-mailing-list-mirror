From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 06/12] wt-status.c: split rebase detection out of
 wt_status_get_state()
Date: Wed, 20 Apr 2016 14:48:07 +0100
Message-ID: <57178897.20509@ramsayjones.plus.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 15:48:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1assUM-0001Zu-Mz
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 15:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbcDTNsO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 09:48:14 -0400
Received: from avasout08.plus.net ([212.159.14.20]:51122 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbcDTNsN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 09:48:13 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout08 with smtp
	id kdo91s0092D2Veb01doBYt; Wed, 20 Apr 2016 14:48:11 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O6PEx0JW c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=GzSnGfWBZQHriJckoesA:9 a=QEXdDO2ut3YA:10 a=EJbmBXp5NkAA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1461158693-21289-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292023>



On 20/04/16 14:24, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> worktree.c:find_shared_symref() later needs to know if a branch is be=
ing
> rebased, and only rebased only. Split this code so it can be used
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Err ... what?

ATB,
Ramsay Jones
