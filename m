From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] bisect--helper: `bisect_voc` shell function in C
Date: Mon, 16 May 2016 08:40:16 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605160838540.3303@virtualbox>
References: <1463169737-12701-1-git-send-email-pranit.bauva@gmail.com> <1463169737-12701-2-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 08:40:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2CCW-0001hC-15
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 08:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbcEPGkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 02:40:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:50698 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbcEPGkP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 02:40:15 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M4TgW-1bnZgs0OpY-00yk1z; Mon, 16 May 2016 08:40:10
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1463169737-12701-2-git-send-email-pranit.bauva@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Kv++jiueXWXJrc1PCLIVJlDRjSAThyDA9z9r0uAM+ZsXskz6r9X
 akFiIKgA34cLTcXCfzj4xbfE5NBuL4zFa9us+DscZZxFPIAkLXollI2WYxq8UI/hXIxlOFW
 XlqX9yDi4vEbrYLXw7b5KGyF+79PmKfunq0WKxjn6JqWMHAPBYoCFPmrbuaiOHs3OYcinUa
 zvM1TVwTHXiGhjsj3AtNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VmQG8783VD4=:H+gIkRZ0V9Ig64AaBGA0pt
 6kqGIpprv3Ibx8Wt/a3ZsbwarD9aAIKJmcikAd3CX758cI1uPHnTGGSGaCIDey2HlBQdwCpdu
 QrP9egr9+egEVtalNMQfnowP46o4Yy7JZYjq3hDno9AxhdWHA6+0405I1bUTRaPU0JkK2q3eJ
 BrYFGEHinoFD+QrMdNWzf3ZVYo0tDGvxQh6tXQwINYZqCHTql1pktrwFI0HL2TXTiSN2ZJOvb
 l3Hwyz9V650BWMkrrejlBDz8qRQ8w7o0UBdc50PH7fKYdW7/MTaduhQQM9Ue++E1DoYGkRr5x
 +fyZpB3KNj967vm4ubSNYMSEJIfdTu6zbcCzWqLvSs0FK18K1LU6Y7owgUk0TMDtUAryUSwiq
 2PDM6qPP7/Vj/gObmxdzmlO7TnyKLqIsv4zrFcDdvVUQJ2MzTb4LbMUr0MqBkc0c2PCq+Jzwz
 Fp7J1CmSlhoQFrC2cXNr2YPeTbfjc1ZC2Rr9wIXUs1jXQFC+91E2jSntEM6Cch25rDq3Z7NMV
 KZIvCg0sfQP8+0YJtegw7fylebV+FMD2jPivLOoTtU7srQlGH630Avi6c2v/WkmIGcLIyrmoL
 gV/jaujFF8G91LAfF4IIRXth1FVusY6Ho6IPDtM2LqmSA3IeqCTIyYznEEwUi6XDkdc92Ihbb
 5zxQoqfpfUAwIGa1QKrBAiM4ESC6HnHWgmDIqvdSJHUoZNXqkfqCBdUryX00qOoe393d7Nbil
 kQo5haRuZ6HMeV0wYYv/OSMJeIvEVxgFJi4g2zX3BMkr6QCih2lkYnsl6bXHkrOQv2Yh9SOf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294726>

Hi Pranit,

On Sat, 14 May 2016, Pranit Bauva wrote:

> Reimplement the `bisect_voc` shell function in C. This is a too small
> function to be called as a subcommand though the working of this
> function has been tested by calling it as a subcommand.

This leaves me puzzled as to what this patch is supposed to do. Maybe
rename this function to have a more intuitive name, and then throw in a
patch that makes use of the function?

Ciao,
Dscho
