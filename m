From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: unable to retrieve new files from the server
Date: Sat, 11 Sep 2010 19:27:52 +0200
Message-ID: <4C8BBC18.5070905@dbservice.com>
References: <1284223572247-5521801.post@n2.nabble.com> <AANLkTimkHjsyaNWV16DccSC-cQpVSPJfi56asMbGtPkX@mail.gmail.com> <1284224128706-5521820.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy <hoangtu69@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 19:28:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuTry-0005cQ-9F
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 19:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004Ab0IKR2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Sep 2010 13:28:00 -0400
Received: from office.neopsis.com ([78.46.209.98]:58320 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab0IKR17 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Sep 2010 13:27:59 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=BAYES_00: -1.665,TOTAL_SCORE: -1.665,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Sat, 11 Sep 2010 19:27:54 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <1284224128706-5521820.post@n2.nabble.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155998>

On 9/11/10 6:55 PM, Andy wrote:
> 
> I did not commit these files.  These files were committed by others.  All I
> want is to make sure my local copy has all the latest from the server.
> 
> What command should I use?

If you are using dumb http, you need to run 'git update-server-info'
after each push to the server. Otherwise pull won't see the new commits.

tom
