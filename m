From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH v2 07/14] imap-send.c: inline imap_parse_list() in
 imap_list()
Date: Tue, 15 Jan 2013 10:51:47 -0800
Message-ID: <20130115185147.GB14552@ftbfs.org>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
 <1358237193-8887-8-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 15 20:06:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvBpq-0007Sk-7X
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 20:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757605Ab3AOSwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 13:52:00 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:44852 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757590Ab3AOSvz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 13:51:55 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1TvBbv-0006sU-2E; Tue, 15 Jan 2013 10:51:47 -0800
Mail-Followup-To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1358237193-8887-8-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213661>

On Tue, Jan 15, 2013 at 09:06:25AM +0100, Michael Haggerty wrote:
> -static struct imap_list *parse_imap_list(struct imap *imap, char **sp)
> +static struct imap_list *parse_list(char **sp)

The commit subject refers to imap_parse_list and imap_list whereas the
code refers to parse_imap_list and parse_list.
