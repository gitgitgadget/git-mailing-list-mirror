From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: (beginner) git rm
Date: Wed, 28 Jan 2009 12:37:41 +0100
Message-ID: <49804385.908@dbservice.com>
References: <1233137498146-2231416.post@n2.nabble.com> <Pine.LNX.4.64.0901281133380.645@ds9.cixit.se> <1233140751523-2231622.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Zabre <427@free.fr>
X-From: git-owner@vger.kernel.org Wed Jan 28 12:40:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS8li-0000ZK-E0
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 12:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbZA1LiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 06:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbZA1LiS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 06:38:18 -0500
Received: from office.neopsis.com ([78.46.209.98]:47798 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbZA1LiS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 06:38:18 -0500
Received: from [192.168.0.130] ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com;
	Wed, 28 Jan 2009 12:38:14 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090126 Shredder/3.0b2pre
In-Reply-To: <1233140751523-2231622.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107528>

On 01/28/2009 12:05 PM, Zabre wrote:
> Another question would be : instead of doing a hard reset (I might have
> other changes in the index that I don't want to loose) is it possible to
> remove only one "delete action" from the index?

Do you mean 'undelete' a file? git checkout d.txt - That restores the 
file in the working tree and resets the index just for that file.

tom
