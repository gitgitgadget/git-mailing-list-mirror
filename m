From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Storing notes refs outside of refs/
Date: Thu, 26 Aug 2010 21:09:31 +0200
Message-ID: <4C76BBEB.3040700@dbservice.com>
References: <4C7681F1.3070205@workspacewhiz.com> <7vy6btl2yo.fsf@alter.siamese.dyndns.org> <4C76B6CF.8040808@dbservice.com> <AANLkTim=P6GwnhuaJrixCZB_USD0NrKT0nN4t6XyEY+6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 21:10:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OohqU-0007h4-AG
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 21:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353Ab0HZTK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 15:10:28 -0400
Received: from office.neopsis.com ([78.46.209.98]:49272 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab0HZTK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 15:10:27 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.066,BAYES_00: -1.665,TOTAL_SCORE: -1.599,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 26 Aug 2010 21:09:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTim=P6GwnhuaJrixCZB_USD0NrKT0nN4t6XyEY+6@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154557>

On 8/26/10 8:51 PM, Sverre Rabbelier wrote:
> Heya,
> 
> On Thu, Aug 26, 2010 at 13:47, Tomas Carnecky <tom@dbservice.com> wrote:
>> Hm, so storing no longer needed branches outside of the refs/heads
>> namespace (so that they don't show up in git branch) is a bad idea?
> 
> You can store them outside refs/heads just fine, as long as they're
> somewhere under refs. For example, refs/attic/ would be perfectly
> safe.

Ah, I missed that Joshua wants to put them outside of .git/refs
(.git/p4). Slight but important difference :)

tom
