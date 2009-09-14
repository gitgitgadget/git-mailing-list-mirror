From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [PATCH 01/17] Avoid declaration after statement
Date: Mon, 14 Sep 2009 21:00:49 +0200
Message-ID: <4AAE92E1.20608@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>	 <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>	 <81b0412b0909140659p2472c026gaece8b9388fb21d6@mail.gmail.com>	 <1976ea660909140704r4b730002o5d3f42463b57828d@mail.gmail.com> <81b0412b0909140710y586f0464vc7a3b08460f453d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 21:00:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnGnD-0007k8-Js
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 21:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756793AbZINTAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 15:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756790AbZINTAl
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 15:00:41 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:38358 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbZINTAl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 15:00:41 -0400
Received: by ey-out-2122.google.com with SMTP id 25so650236eya.19
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 12:00:43 -0700 (PDT)
Received: by 10.211.155.19 with SMTP id h19mr3564629ebo.48.1252954843560;
        Mon, 14 Sep 2009 12:00:43 -0700 (PDT)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206])
        by mx.google.com with ESMTPS id 5sm327471eyf.9.2009.09.14.12.00.41
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Sep 2009 12:00:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <81b0412b0909140710y586f0464vc7a3b08460f453d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128488>

Alex Riesen said the following on 14.09.2009 16:10:
> On Mon, Sep 14, 2009 at 16:04, Frank Li <lznuaa@gmail.com> wrote:
>>>> Microsoft Visual C++ does not understand this C99 style
>>>> 
>>> But you don't use the C++ compiler (which does understand that
>>> syntax).
>>> 
>> Microsoft Visual C++ is product name. If you think it is confuse,
>> it can change to "MSVC"
> 
> I do. OTOH, some people actually use a "product" to compile
> "software", so maybe it is okay.

Ok, I'll s/Microsoft Visual C++/MSVC/ and resend tomorrow, just to be 
consistent with the other patches.

--
.marius
