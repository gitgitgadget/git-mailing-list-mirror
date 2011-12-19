From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: Re* How to generate pull-request with info of signed tag
Date: Mon, 19 Dec 2011 21:40:37 +0530
Message-ID: <87iplch79e.fsf@linux.vnet.ibm.com>
References: <874nx1korf.fsf@linux.vnet.ibm.com> <7vbor8jw0h.fsf@alter.siamese.dyndns.org> <871us3l45o.fsf@linux.vnet.ibm.com> <7viplfdlpb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 17:13:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcfqb-0005oR-Iu
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 17:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706Ab1LSQNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 11:13:49 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:47844 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204Ab1LSQNs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 11:13:48 -0500
Received: from /spool/local
	by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
	Mon, 19 Dec 2011 11:13:47 -0500
Received: from d01relay03.pok.ibm.com (9.56.227.235)
	by e3.ny.us.ibm.com (192.168.1.103) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Mon, 19 Dec 2011 11:11:13 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pBJGB6Lh278912
	for <git@vger.kernel.org>; Mon, 19 Dec 2011 11:11:06 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id pBJGAiBi021181
	for <git@vger.kernel.org>; Mon, 19 Dec 2011 14:10:44 -0200
Received: from skywalker.linux.vnet.ibm.com ([9.80.64.20])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id pBJGAda6020666;
	Mon, 19 Dec 2011 14:10:42 -0200
In-Reply-To: <7viplfdlpb.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/0.10.2+102~g61445d1 (http://notmuchmail.org) Emacs/23.3.1 (x86_64-pc-linux-gnu)
x-cbid: 11121916-8974-0000-0000-000004654509
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187454>

On Sat, 17 Dec 2011 11:47:44 -0800, Junio C Hamano <gitster@pobox.com> wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> 
> > Tested-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> >
> > -aneesh
> 
> Thanks.

It would be nice to get the below working

git fetch git-url tag remote-tag-name:local-namespace/tag-name

That way we can make sure before merging i can cut-paste that url and
the local tag name i wish to store this to. And then do a git-merge.

-aneesh
