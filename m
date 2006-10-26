X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/3] make =?iso-8859-1?q?index-p=E2ck?= able to complete thin packs
Date: Thu, 26 Oct 2006 11:13:47 +0100
Message-ID: <tnxac3j4c6c.fsf@arm.com>
References: <Pine.LNX.4.64.0610252323100.12418@xanadu.home>
	<7vr6wvr1ca.fsf@assigned-by-dhcp.cox.net> <ehppbg$phq$1@sea.gmane.org>
	<20061026091925.GD13780@diana.vm.bytemark.co.uk>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 10:14:09 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061026091925.GD13780@diana.vm.bytemark.co.uk> (
 =?iso-8859-1?q?Karl_Hasselstr=F6m's_message_of?= "Thu, 26 Oct 2006 11:19:25
 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 26 Oct 2006 10:13:48.0387 (UTC) FILETIME=[6D70A330:01C6F8E7]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30179>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd2FJ-0001gC-7F for gcvg-git@gmane.org; Thu, 26 Oct
 2006 12:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423135AbWJZKNy convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 06:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423140AbWJZKNy
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 06:13:54 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:36586 "EHLO
 cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP id
 S1423135AbWJZKNx convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>);
 Thu, 26 Oct 2006 06:13:53 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63]) by
 cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k9QADnQb017193;
 Thu, 26 Oct 2006 11:13:49 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by
 cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0); Thu, 26 Oct 2006
 11:13:48 +0100
To: =?iso-8859-1?q?Karl_Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2006-10-26 09:50:48 +0200, Jakub Narebski wrote:
>
>> That said, git-am should understand QP with coding in mail headers.
>
> I really hope it does, since I just patched StGIT to generate such
> headers. (Out of pure vanity -- I don't want my name mangled!)

It looks like it does, that's how I applied some of your patches ('stg
import' doesn't understand them).

--=20
