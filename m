From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Storing notes refs outside of refs/
Date: Thu, 26 Aug 2010 20:47:43 +0200
Message-ID: <4C76B6CF.8040808@dbservice.com>
References: <4C7681F1.3070205@workspacewhiz.com> <7vy6btl2yo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 20:48:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OohUt-0001TV-5m
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 20:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab0HZSsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 14:48:18 -0400
Received: from office.neopsis.com ([78.46.209.98]:60114 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab0HZSsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 14:48:16 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.067,BAYES_00: -1.665,TOTAL_SCORE: -1.598,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 26 Aug 2010 20:47:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <7vy6btl2yo.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154553>

On 8/26/10 7:05 PM, Junio C Hamano wrote:
> Joshua Jensen <jjensen@workspacewhiz.com> writes:
> 
>> I tried manually moving .git/refs/notes/p4notes to .git/p4/p4notes.
> 
> Bad idea.  Your notes no longer are protected from fsck and prune.

Hm, so storing no longer needed branches outside of the refs/heads
namespace (so that they don't show up in git branch) is a bad idea? This
suggestion was made in #git today or yesterday and I'd like to know if I
should advise people against doing that.

tom
