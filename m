From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 15:12:18 +0100
Message-ID: <20100113141218.GA17687@inner.home.ulmdo.de>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi> <fcaeb9bf1001130539p2971caavd101d46de9269769@mail.gmail.com> <20100113135753.GA7095@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 13 15:12:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV3xY-00048i-JK
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 15:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110Ab0AMOM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 09:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755140Ab0AMOM2
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 09:12:28 -0500
Received: from continuum.iocl.org ([213.146.114.200]:61865 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894Ab0AMOM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 09:12:27 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id o0DECJF19782;
	Wed, 13 Jan 2010 15:12:19 +0100
Content-Disposition: inline
In-Reply-To: <20100113135753.GA7095@Knoppix>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136822>

On Wed, 13 Jan 2010 15:57:53 +0000, Ilari Liusvaara wrote:
...
> And one would need custom daemon anyway even if one used stunnel. 
> git-daemon just can't deal with authentication data.

It doesn't need to, really. stunnel sets the environment variable
SSL_CLIENT_DN with the distinguished name of the client certificate,
which can be used in the hook scripts ('update') on the server.

(I looked into that stuff once, but with the advent of smart-http(s)
I pretty much lost any interest to try implementing gits:// via
openssl here, as it isn't yet an actual itch.)

Andreas
