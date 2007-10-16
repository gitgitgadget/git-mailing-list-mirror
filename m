From: "franky" <yinping@kooxoo.com>
Subject: RE: Is there any plan to support partial checkout or submoudule improvement?
Date: Tue, 16 Oct 2007 16:27:19 +0800
Message-ID: <20071016082720.E5EDA7E6F@mail.kooxoo.com>
References: <8c5c35580710160108s4faeaa61k7585d01703c0c8fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Lars Hjemli'" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 10:27:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihhm3-0004y6-UB
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 10:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756AbXJPI1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 04:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755578AbXJPI1Y
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 04:27:24 -0400
Received: from mail.kooxoo.com ([60.28.194.208]:38933 "EHLO mail.kooxoo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753757AbXJPI1X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 04:27:23 -0400
Received: from yinping (unknown [124.42.17.129])
	by mail.kooxoo.com (Postfix) with ESMTP id E5EDA7E6F;
	Tue, 16 Oct 2007 16:27:20 +0800 (CST)
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <8c5c35580710160108s4faeaa61k7585d01703c0c8fc@mail.gmail.com>
Thread-Index: AcgPy+OFL/153+PVRKyyny9HYntkvgAAke0A
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61116>

It works. However, I want a single "git-pull" to deploy a new version and a
single "git-reset" to back to versions before. So I need another resolution.

 franky

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf
Of Lars Hjemli
Sent: Tuesday, October 16, 2007 4:08 PM
To: franky
Cc: git@vger.kernel.org
Subject: Re: Is there any plan to support partial checkout or submoudule
improvement?

On 10/16/07, franky <yinping@kooxoo.com> wrote:
> 2. src, bin not submoudle, just sub directory
>         When src changes, compiled binaries are still put in bin
directory.
> However, only one commit is required. Perfect? No, another problem when
> deploying. I don't want the src directory to appear in the deployment
> directory.

If this is just for deployment of your bin directory, you can try

$ cd Project/bin
$ git archive --prefix='Project/bin/' HEAD | gzip > Project-x.y.tar.gz

--
larsh
