From: Greg Price <price@MIT.EDU>
Subject: Re: [PATCH 6/6] rebase --rewrite-refs: tests
Date: Tue, 28 Jun 2011 07:20:12 -0400
Message-ID: <20110628112012.GW5771@dr-wily.mit.edu>
References: <cover.1309133817.git.greg@quora.com> <ab6d17ba0ea919e0f873597b60d6c7e9a43460c8.1309133817.git.greg@quora.com> <7vy60nugwj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 13:38:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbWcC-0001Al-5W
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 13:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757227Ab1F1LVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 07:21:37 -0400
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:56938 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755022Ab1F1LUO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2011 07:20:14 -0400
X-AuditID: 12074424-b7bc6ae000005a77-8b-4e09b8ed43b3
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 98.9D.23159.DE8B90E4; Tue, 28 Jun 2011 07:20:13 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id p5SBKDgn008102;
	Tue, 28 Jun 2011 07:20:13 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p5SBKCA4016885;
	Tue, 28 Jun 2011 07:20:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vy60nugwj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixCmqrPt2B6efwdJWc4uuK91MFg29V5gd
	mDwuXlL2+LxJLoApissmJTUnsyy1SN8ugSvj69Pd7AVtTBW/t25jamA8z9jFyMkhIWAi8eHT
	QVYIW0ziwr31bF2MXBxCAvsYJabNuM0K4WxglNj07zNYlZDAF0aJixs5QGwWAVWJK+s3gE1i
	E1CQ+DF/HTOILSKgJjGx7RALiM0sIC6xbu559i5GDg5hAVOJ/rdmICavgLHEvsZ0iIlLGCVO
	XU0GsXkFBCVOznwC1aklcePfSyaQcmYBaYnl/zhATE4BM4n973JATFEBFYlVSzMnMArOQtI7
	C0nvLITeBYzMqxhlU3KrdHMTM3OKU5N1i5MT8/JSi3TN9XIzS/RSU0o3MYIClt1FZQdj8yGl
	Q4wCHIxKPLyMKzn8hFgTy4orcw8xSnIwKYnyGgDDXYgvKT+lMiOxOCO+qDQntfgQowQHs5II
	71QjoBxvSmJlVWpRPkxKmoNFSZy31Pu/r5BAemJJanZqakFqEUxWhoNDSYL323agRsGi1PTU
	irTMnBKENBMHJ8hwHqDhYIt5iwsSc4sz0yHypxgVpcR5dUASAiCJjNI8uF5YQnnFKA70ijCv
	KkgVDzAZwXW/AhrMBDS4rBZscEkiQkqqgbHD/sFDDZeWZwtbpSUSDkpc8+BUmOjsz1sz/dDE
	pXMljCJM1I2UXLfvlZYyu7tqf4TtP67/2+OKbjOpisRfc3ab1hPh/++0cLpr9d2EmQFSew66
	b1Z2/G0m2H3VN/bblfJKnW6VKZXnc3Y3ZAlHCRcI7Pq56JnCYmuBuUtnzZg8Lf1h 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176394>

On Mon, Jun 27, 2011 at 02:02:36PM -0700, Junio C Hamano wrote:
> Greg Price <price@MIT.EDU> writes:
> 
> > diff --git a/t/t3420-rebase-ref.sh b/t/t3420-rebase-ref.sh
> > new file mode 100644
> 
> Forgot the executable bit?

Yup, thanks, fixed.

Greg
