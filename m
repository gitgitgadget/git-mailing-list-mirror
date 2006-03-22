From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Cloning from sites with 404 overridden
Date: Wed, 22 Mar 2006 09:22:27 -0800
Message-ID: <20060322172227.GO3997@reactrix.com>
References: <20060322025921.1722.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 18:22:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM72d-0001qv-Fk
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 18:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWCVRWh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 12:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWCVRWg
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 12:22:36 -0500
Received: from 241.37.26.69.virtela.com ([69.26.37.241]:34100 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750988AbWCVRWg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 12:22:36 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k2MHMS3p021268;
	Wed, 22 Mar 2006 09:22:28 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k2MHMSJa021266;
	Wed, 22 Mar 2006 09:22:28 -0800
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20060322025921.1722.qmail@science.horizon.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17817>

On Tue, Mar 21, 2006 at 09:59:21PM -0500, linux@horizon.com wrote:

> If someone feels ambitious, you can detect this condition automatically
> by searching for a file that you know won't be there and seeing if you
> get a 404 response to that.

It might be feasible to detect this condition using the Content-Type:
header in the server response.  So far, all the GIT repositories I've
tried return text/plain for loose objects and a special 404 page will
likely be text/html.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
