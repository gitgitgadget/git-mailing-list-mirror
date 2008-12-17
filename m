From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: Re: white spaces in a patch
Date: Wed, 17 Dec 2008 13:15:56 +0100
Organization: Intra2net AG
Message-ID: <200812171316.21531.thomas.jarosch@intra2net.com>
References: <dac45060812162331k19272488r4e95e0555e7a6db9@mail.gmail.com> <bd6139dc0812170413j5ed2d9eak89df8517bc91c5fd@mail.gmail.com> <dac45060812170413w7c8cffaifa1a0f3b649474e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Sverre Rabbelier" <srabbelier@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Mark Ryden" <markryde@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 13:18:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCvLV-0006gl-B5
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 13:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbYLQMQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 07:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbYLQMQ1
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 07:16:27 -0500
Received: from rs02.intra2net.com ([81.169.173.116]:59842 "EHLO
	rs02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbYLQMQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 07:16:26 -0500
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rs02.intra2net.com (Postfix) with ESMTP id E8F1D8CC7;
	Wed, 17 Dec 2008 13:16:22 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id 6AB8D2AC4B;
	Wed, 17 Dec 2008 13:16:22 +0100 (CET)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id A4DA02AC4A;
	Wed, 17 Dec 2008 13:16:21 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-41.fc9.i686; KDE/4.1.3; i686; ; )
In-Reply-To: <dac45060812170413w7c8cffaifa1a0f3b649474e4@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intranator.com) with AMaViS and F-Secure AntiVirus (fsavdb 2008-12-17_01)
X-Spam-Status: hits=-2.0 tests=[ALL_TRUSTED=-1.8,BAYES_40=-0.185]
X-Spam-Level: 980
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103340>

On Wednesday, 17. December 2008 13:13:34 Mark Ryden wrote:
[colors in diff]
> What do you mean ?
> where ? how ?

This should do the trick:

git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto

Thomas
