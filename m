From: David Brown <davidb@quicinc.com>
Subject: Re: [PATCH] commit: More generous accepting of RFC-2822 footer
 lines.
Date: Wed, 28 Oct 2009 07:23:28 -0700
Message-ID: <20091028142328.GA13343@huya.quicinc.com>
References: <20091027234520.GA11433@quaoar.codeaurora.org>
 <20091028000511.GK10505@spearce.org>
 <7vk4yguh00.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Brown <davidb@codeaurora.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 15:23:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N39RJ-0000XR-KO
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 15:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbZJ1OXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 10:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753899AbZJ1OXe
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 10:23:34 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:51789 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbZJ1OXd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 10:23:33 -0400
X-IronPort-AV: E=McAfee;i="5300,2777,5784"; a="26287594"
Received: from pdmz-ns-mip.qualcomm.com (HELO numenor.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Oct 2009 07:23:38 -0700
Received: from msgtransport01.qualcomm.com (msgtransport01.qualcomm.com [129.46.61.148])
	by numenor.qualcomm.com (8.14.2/8.14.2/1.0) with ESMTP id n9SENcEx012324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Wed, 28 Oct 2009 07:23:38 -0700
Received: from huya.quicinc.com (huya.qualcomm.com [10.46.167.38])
	by msgtransport01.qualcomm.com (8.14.2/8.14.2/1.0) with ESMTP id n9SENWDt028311
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 28 Oct 2009 07:23:37 -0700
Content-Disposition: inline
In-Reply-To: <7vk4yguh00.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131464>

On Wed, Oct 28, 2009 at 12:14:55AM -0700, Junio C Hamano wrote:

> When deciding to omit adding a new S-o-b, we deliberately check only the
> last S-o-b to see if it matches what we are trying to add.  This is so
> that a message from you, that has my patch that was reviewed and touched
> up by you with your sign-off, i.e.

This is good to know.  I'll leave the existing last-SoB test in
place then, and just use the sophisticated check for a block of
RFC2822 footers to determine if there should be a blank line.

Jeff also pointed out that I should probably also allow lines
starting with whitespace to be considered header lines.

David
