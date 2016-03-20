From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GSoC Project | Improvise git bisect
Date: Sun, 20 Mar 2016 16:31:07 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603201628590.4690@virtualbox>
References: <CAFZEwPN-oUDNnc_PBeP2Q4msJAHenkiLtE+Oo75R+uTTwUKpYQ@mail.gmail.com> <vpqoaaahbvi.fsf@anie.imag.fr> <CAP8UFD2fudNtGpUHTYjZKXCErocuRS65E=5tH_+_tsNFbmHCBA@mail.gmail.com> <CAFZEwPMeejJEMjYbx1sJsH0UNygDEdtNazceOePo81Abi0dHHQ@mail.gmail.com>
 <CAFZEwPP2OLOQanazPXxK1u5GVHzFWqx8GuRad7tLUyHrWR_+Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, Troy Moure <troy.moure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kevin Daudt <me@ikke.info>,
	Philip Oakley <philipoakley@iee.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 16:33:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahfLo-0003pv-Rk
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 16:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867AbcCTPbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 11:31:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:52984 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755600AbcCTPbe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 11:31:34 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MhRUQ-1aTrYb06oU-00MchL; Sun, 20 Mar 2016 16:31:11
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAFZEwPP2OLOQanazPXxK1u5GVHzFWqx8GuRad7tLUyHrWR_+Tw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:0DXvuk1QxMhsFngRlQMlw9bxmcYGkie+l5A8/ZWXjt8Cn65wbdO
 oSrJPxU9dRYQqlawzRzwo9Ui9XS4uZjT7Tqa5Jkn9dD/j3CynY2n94u7zlm2Aw/HDxEPdB+
 rD+F1SJJHb+dMe7Cb050xqrdLeyorSBBnRU9oHvK5APdIsqHjga/SKt4vnZwrw9xpRDdaii
 ui8bcuRMlIF0XK81PcaRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:orfnBKCOWvs=:3rurz2Yn9zof5dMaicfJ2T
 5wMPKsWjZqd/gSTz5ThgpkotOaFWQaA2/PO3L++jolOE/TqT0gzpFfxNCj9qMIMCRjINp/rtv
 jshvm0/JMtPxf8CIttoRcoxO8ElIDI5U0A28UrzA8xVQ4eB25hCQ5WMOP+2I5Anhof3VP128T
 DXTm5/3cCDCu+WVWqc39o2PykMN5nXLpYYO46jmkdsBl/pu1Dv2oaIWs1pGX4LPJnHUOan3l4
 GjdF6Vo/uB8brz3z6aroYZoXrLGY51FRLz/fKni9HswX5tEEQuE7vcKDvvF6bEkXG2qcohPw1
 HdRFf7VF/wNoqABILN+w9hXHmxb91tjp5K+kaiCpYCgFOLk5xcQebXxH2mfhR5R4ozPrdDPiu
 lCCS3/kdW9ryrQ9gE6cQ+goSkGNRFsJ5wxbf+6oHah2UhVY+hZkrY+es4CalPeyTQtm6agCfd
 Tl9Rrh/UDg3EC2DTuzmrpkdwN5nsTQxOIcjzis3ityjhMaNJDQjvmSF3Xf24hmIxuGwMNXMxw
 3pfC8NmukCIrXFCJxun0UiqbPg3qOpCYh/DmZ4CNrUF2pYmSLOgEvQ1AfJrEd4vyrgcifg6OP
 +X1J9/J+DNuYvTOURqDifrPX66Q9p4yV3aUiWs0SLqmbxo2CCXb2H2QTo8ASYCZYbXJOGQQal
 Xsd5O0YBsbsNv3XxTWXeFgQl1tewrDVZcvdYgEvDOHyCrH83LoYnsK9qMiSWCzi6/mrRvPmYy
 C6bmTWGO3JsfySLpjatE/AP8vsGL9uT8jh9Um8mtxwW3pwJIpuPMArID/dhV+jGwVh3R1uzX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289358>

Hi,

On Sun, 20 Mar 2016, Pranit Bauva wrote:

> The plan:
> 
>  - Place bisect.c in builtin/
>  - Implement a skeletal cmd_bisect() which will redirect to
> git-bisect.sh (1e1ea69f)

I would highly advise a different course of action:

- move functionality one by one from bisect.sh to builtin/bisect--helper.c

That way, you do not have to deal with a lot of infrastructure at the
beginning of your project because bisect--helper is already a builtin;
Instead, you can dive right in and implement satisfyingly noticable
improvements.

Ciao,
Johannes
