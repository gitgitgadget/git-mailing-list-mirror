From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add test case for ls-files --with-head
Date: Wed, 03 Oct 2007 18:15:56 +0200
Message-ID: <85ejgcrx6r.fsf@lola.goethe.zz>
References: <1191390255.16292.2.camel@koto.keithp.com>
	<7vtzp8g2s2.fsf@gitster.siamese.dyndns.org>
	<87y7ekr86e.wl%cworth@cworth.org> <47038669.30302@viscovery.net>
	<Pine.LNX.4.64.0710031634300.28395@racer.site>
	<87myv0qj2u.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 21:11:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id9cz-00060A-Rv
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 21:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbXJCTLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 15:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753667AbXJCTLK
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 15:11:10 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:54993 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbXJCTLH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 15:11:07 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Id9bT-0005RU-2e; Wed, 03 Oct 2007 15:09:51 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id CDECF1C4CE13; Wed,  3 Oct 2007 18:15:56 +0200 (CEST)
In-Reply-To: <87myv0qj2u.wl%cworth@cworth.org> (Carl Worth's message of "Wed\, 03 Oct 2007 09\:06\:01 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59868>

Carl Worth <cworth@cworth.org> writes:

> On Wed, 3 Oct 2007 16:36:13 +0100 (BST), Johannes Schindelin wrote:
>> Or as
>>
>> 	i=1
>> 	while test $i -le 50
>> 	do
> ...
>> 		i=$(($i+1))
>> 	done
>
> /me steps aside to let the shell-script wizards finish the job

for i in {1,2,3,4,5}{0,1,2,3,4,5,6,7,8,9}
do
  ...
done

There is enough room for perversion in shell programming for everyone...

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
