From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Add git svn gc command
Date: Mon, 20 Jul 2009 13:41:59 +0200
Message-ID: <200907201342.01912.trast@student.ethz.ch>
References: <8E0EFA3B-E8C0-4030-8BAE-E8EF65694031@gmail.com> <20090720083621.GA3237@dcvr.yhbt.net> <9b18b3110907200202kbb78c8dm43e0451900e4f2fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Robert Zeh <robert.a.zeh@gmail.com>, git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 13:42:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSrG7-0006Xy-Fe
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 13:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbZGTLmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 07:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbZGTLmJ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 07:42:09 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:44012 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbZGTLmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 07:42:09 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 20 Jul 2009 13:42:07 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 20 Jul 2009 13:42:07 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.23-0.1-default; KDE/4.2.96; x86_64; ; )
In-Reply-To: <9b18b3110907200202kbb78c8dm43e0451900e4f2fb@mail.gmail.com>
X-OriginalArrivalTime: 20 Jul 2009 11:42:07.0119 (UTC) FILETIME=[1BFD79F0:01CA092F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123587>

demerphq wrote:
> 
> my $can_compress= eval "require Compress::Zlib; 1";

Wouldn't

  my $can_compress = eval { require Compress::Zlib; 1 };

be better on the grounds that this will catch compilation errors in
the eval'd statement at compilation (of the main program) time?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
