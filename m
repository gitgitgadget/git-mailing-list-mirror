From: Joe Perches <joe@perches.com>
Subject: Re: git-send-email.perl defect: address missing trailing > accepted
Date: Tue, 20 Oct 2009 16:00:33 -0700
Message-ID: <1256079633.2029.81.camel@Joe-Laptop.home>
References: <1256076767.2029.59.camel@Joe-Laptop.home>
	 <40aa078e0910201529m338ef3d1o4fa1a31c3dcc2a20@mail.gmail.com>
	 <1256078917.2029.77.camel@Joe-Laptop.home>
	 <40aa078e0910201556h4757dbbdn853be4dd8aa920d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Oct 21 01:13:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0NhC-0000j6-AB
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 01:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbZJTXAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 19:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbZJTXAb
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 19:00:31 -0400
Received: from mail.perches.com ([173.55.12.10]:2288 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851AbZJTXA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 19:00:29 -0400
Received: from [192.168.1.151] (Joe-Laptop.home [192.168.1.151])
	by mail.perches.com (Postfix) with ESMTP id 2B22624368;
	Tue, 20 Oct 2009 16:00:30 -0700 (PDT)
In-Reply-To: <40aa078e0910201556h4757dbbdn853be4dd8aa920d0@mail.gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130866>

On Wed, 2009-10-21 at 00:56 +0200, Erik Faye-Lund wrote:
> Didn't my version work for you? It worked for me.

Hi Erik.

It worked, but an unexplained die isn't great,
so I put it where the other validations are done.

It seems that the regex for address validation
isn't very good and perhaps there could/should
be a stronger validation done for each address
entered.

cheers, Joe
