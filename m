From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] Rename git-core rpm to just git and rename the
	meta-pacakge to git-all.
Date: Mon, 18 Feb 2008 11:04:36 -0500
Message-ID: <1203350676.4082.0.camel@gaara.boston.redhat.com>
References: <1203100163-17509-1-git-send-email-krh@redhat.com>
	 <7vskzs2exj.fsf@gitster.siamese.dyndns.org>
	 <76718490802180651h2ad61c4cg50bae97000957397@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 17:37:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR8zf-0007Kj-I2
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 17:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760005AbYBRQgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 11:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760000AbYBRQgI
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 11:36:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46386 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759902AbYBRQgF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 11:36:05 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m1IG4ioA031350;
	Mon, 18 Feb 2008 11:04:44 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1IG4iBU018702;
	Mon, 18 Feb 2008 11:04:44 -0500
Received: from [192.168.1.105] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1IG4fSl006661;
	Mon, 18 Feb 2008 11:04:42 -0500
In-Reply-To: <76718490802180651h2ad61c4cg50bae97000957397@mail.gmail.com>
X-Mailer: Evolution 2.21.4 (2.21.4-1.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74312>

On Mon, 2008-02-18 at 09:51 -0500, Jay Soffian wrote:
> On Feb 17, 2008 2:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> > "yum install git" and "yum install git-core" do not give such an
> > error but the latter gives quite a bunch of errors ("yum install
> > git" goes alright).  This is problem #2.
> 
> You probably want "yum upgrade git-core".
> 
> The "problem" is that yum by default doesn't process RPM renames (obsoletes)
> unless you either have obsoletes=1 in your yum.conf, use "yum --obsoletes
> update" or use "yum upgrade".

Ah, that's what it is.  Thanks, I wasn't aware of this issue.

Kristian
