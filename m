From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [RFC] Support for HP NonStop
Date: Wed, 19 Sep 2012 10:16:15 +0200
Message-ID: <000001cd963f$0a8421b0$1f8c6510$@schmitz-digital.de>
References: <005501cd822d$bf844bb0$3e8ce310$@schmitz-digital.de> <7v4nnsyrp7.fsf@alter.siamese.dyndns.org> <005701cd8239$1a828300$4f878900$@schmitz-digital.de> <alpine.LNX.2.01.1209190923020.32503@nerf07.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
To: "'Jan Engelhardt'" <jengelh@inai.de>
X-From: git-owner@vger.kernel.org Wed Sep 19 10:16:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEFST-0002PI-Ii
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 10:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837Ab2ISIQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 04:16:23 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:57126 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab2ISIQT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 04:16:19 -0400
Received: from DualCore (dsdf-4d0a1993.pool.mediaWays.net [77.10.25.147])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MYcHS-1T1TbG3zIw-00VRwK; Wed, 19 Sep 2012 10:16:17 +0200
In-Reply-To: <alpine.LNX.2.01.1209190923020.32503@nerf07.vanv.qr>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJdqfapyoHz4H9Ne772bOxBhhZ91QJGkyzrAdYNcY0CB42PrJZABf+A
Content-Language: de
X-Provags-ID: V02:K0:B2f/EVpqwIUF2NQuFrNsvDsRK8US2gIIl5qm6JQ6UX1
 TTrrAjqwiiyQ6PR1CvNFgi7Kp+w6GNa8Htup63GeFwonWHfkqZ
 MDKQA22X6a6qWlb29DTZk6Txy6qv+VcI8DuOASyi8f6d1FCSH+
 KqFecXJKbDzyRDDgZA7PhZcgDwVr6R66gvsWbdhGArbZeZjK4K
 w7U0/erqXjSo/58Mvgpg+6aD/LYko131cr3j04lwJDcLitiIGN
 rbfYacnEOHN6kkvwAH4PvqjA/02+BfplDHUEQjfmNdyneQ57RJ
 sUJosOAtzkkKWeicvrfDUxwiCM52eA8+yT1M3Oa3acOEeg+DJs
 GvfsYegDdMnRD+o3LAhkFZ+vuSq4lPt81GLXQcp9YvqJnHs6M2
 smYECids4rnKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205916>

> From: Jan Engelhardt [mailto:jengelh@inai.de]
> Sent: Wednesday, September 19, 2012 9:24 AM
> To: Joachim Schmitz
> Cc: 'Junio C Hamano'; git@vger.kernel.org
> Subject: RE: [RFC] Support for HP NonStop
> 
> 
> On Friday 2012-08-24 22:43, Joachim Schmitz wrote:
> >
> >> By the way, is "int" wide enough [for intptr_t/uintptr_t],
> >> or should they be "long"?
> >
> >int and long have the same size, 32-bit, here on NonStop.
> >But we do have 64-bit types too. Not sure which to take though.
> 
> intptr_t is supposed to hold a void * pointer, so should be
> at least as big.

OK, thanks. We are on IA64 but still use the ILP32 model (so 32bit pointers. Support for LP64 has been added recently, but isn't the
default.
However, long changes from 32bit to 64 bit when changing from ILP32 to LP64, so is the save bet here, right?
