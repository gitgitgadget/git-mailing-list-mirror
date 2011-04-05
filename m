From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git exhausts memory.
Date: Tue, 5 Apr 2011 18:19:30 -0400
Message-ID: <BANLkTim-6L1ZeaPT3tVWmyhj-rX1iURQ3g@mail.gmail.com>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
 <alpine.LFD.2.00.1104021103130.28032@xanadu.home> <BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com>
 <alpine.LFD.2.00.1104031110150.28032@xanadu.home> <BANLkTinCwZG3+0Ss8o9ODptg=L8LKKN7aQ@mail.gmail.com>
 <BANLkTinU7x16yp+y-HW9UhkVn9SftOJCcA@mail.gmail.com> <4D9B47D2.6050909@ira.uka.de>
 <BANLkTikanSa3D1Bd8kSySPWQhcj1y8N+qA@mail.gmail.com> <7vzko4mw44.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1104051655310.28032@xanadu.home> <7vmxk4l4yb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Alif Wahid <alif.wahid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 00:19:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7EbM-0004Ow-6k
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 00:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303Ab1DEWTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 18:19:51 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52107 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239Ab1DEWTu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 18:19:50 -0400
Received: by vws1 with SMTP id 1so675602vws.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 15:19:50 -0700 (PDT)
Received: by 10.52.88.12 with SMTP id bc12mr304229vdb.243.1302041990206; Tue,
 05 Apr 2011 15:19:50 -0700 (PDT)
Received: by 10.52.166.133 with HTTP; Tue, 5 Apr 2011 15:19:30 -0700 (PDT)
In-Reply-To: <7vmxk4l4yb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170929>

On Tue, Apr 5, 2011 at 18:16, Junio C Hamano <gitster@pobox.com> wrote:
> Nicolas Pitre <nico@fluxnic.net> writes:
>
>>> > This is only implemented inside of fast-import. pack-objects does not
>>> > honor this variable.
>>>
>>> Do you mean perhaps we should?
>>
>> Yes.
>>
>> Acked-by: Nicolas Pitre <nico@fluxnic.net>
>
> I actually was somewhat unhappy to use uintmax_t type in the public header
> for some reason I cannot quite explain (perhaps religious), and was hoping
> somebody with more sanity than myself would stop me or show me a better
> way.

unsigned long? Without even looking at the source, I bet that is the
type used by pack-objects for the size member that you are comparing
against.

-- 
Shawn.
