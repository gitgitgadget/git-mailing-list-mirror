From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Excessive mmap [was Git server eats all memory]
Date: Mon, 09 Aug 2010 19:45:19 +0200
Message-ID: <4C603EAF.10500@dbservice.com>
References: <wesfwyupgrg.fsf@kanis.fr> <AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com> <87ocdhlgbl.fsf@kanis.fr> <AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com> <AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com> <87hbj74pve.fsf@kanis.fr> <AANLkTinyX9cABkEDy3HBZoDVNWos2djNBSaw2Hg_yzAO@mail.gmail.com> <wesy6cgm6wd.fsf_-_@kanis.fr> <AANLkTi=6JcwLuyNWq9oYzE_E+7DSn-sEvR-X3AHvXM6U@mail.gmail.com> <westyn3n3sa.fsf@kanis.fr> <AANLkTiktriuvciNTNPD4941AG3th6rWwUYT4v_UnaAz3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ivan Kanis <expire-by-2010-08-14@kanis.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	jaredhance@gmail.com, jnareb@gmail.com, git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 19:45:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiWPm-0000Ma-UV
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 19:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab0HIRpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 13:45:30 -0400
Received: from office.neopsis.com ([78.46.209.98]:51803 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab0HIRp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 13:45:28 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.041,BAYES_00: -1.665,TOTAL_SCORE: -1.624,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Mon, 9 Aug 2010 19:45:21 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTiktriuvciNTNPD4941AG3th6rWwUYT4v_UnaAz3@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152992>

On 8/9/10 6:50 PM, Avery Pennarun wrote:
> On the other hand, perhaps a more important question is: why does git
> feel like it needs to generate entirely new packs for each person
> doing a clone on your system?  Shouldn't it be reusing existing ones
> and just streaming them straight out to the recipient?

Isn't that something that the rev cache is supposed to fix?

tom
