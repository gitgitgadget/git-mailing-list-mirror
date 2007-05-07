From: "Chris Riddoch" <riddochc@gmail.com>
Subject: gitweb css - pixels?!
Date: Mon, 7 May 2007 17:13:42 -0600
Message-ID: <6efbd9b70705071613p23017509qaf9af12c1d14f9cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 01:13:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlCOu-0006eS-Tp
	for gcvg-git@gmane.org; Tue, 08 May 2007 01:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966717AbXEGXNp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 19:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755245AbXEGXNp
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 19:13:45 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:40365 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194AbXEGXNo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 19:13:44 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1760695nzf
        for <git@vger.kernel.org>; Mon, 07 May 2007 16:13:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SQ+pqaD9bd3NNCVXxfnycThSBWMFgxtwWCrjWs45hmeFObz01Awi0A6H6nnDh6C1t9Vo4iaqpn7xDoTSKeojOzSYcSP/dBS3ZIWUhr+DOs41e4UTmzdRMaXB2ShKE69MfUJASgswBXOuLO6aEVt5d438T1G6Vqf0LOv1e2e4Z0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=InspArc47tnGyijckOCfIXJ/iPz/XLFrNI/TO/iP+IBP95SU1vqyYGIWdtVnQaA7dqAzLlEPbAFA4H8/hBuqbS+ljRG52zWszall6+B6AzNVnnOvleATHSC51mG6mgStTsDoeJKlgdWSvkKR8np6CI+kc4C/zEXnn51Z0xs+Fp8=
Received: by 10.114.159.1 with SMTP id h1mr2334816wae.1178579623726;
        Mon, 07 May 2007 16:13:43 -0700 (PDT)
Received: by 10.115.22.19 with HTTP; Mon, 7 May 2007 16:13:42 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46498>

Hi, folks.

I've been gradually converting my ~/src directory full of tarballs
I've found interesting enough to download to a ~/repos/ directory
containing bare git repositories of the projects.  I was thinking it
might be worth my while to set up gitweb so I can peruse my collection
of projects.

I noticed myself squinting, on my 1400x1050 laptop screen, at the 10
and 12-*pixel* font settings gitweb's CSS specifies before thinking to
myself that I should bring this to the list's attention.

I'm no CSS guru, or I'd just provide a patch.  It seems that *all* the
measurements specified in the CSS file are in pixels, not ems or
percentages.  There's got to be a better way.  I can't be the only
person who would rather use my nice screen to render attractive,
readable fonts rather than to render the smallest possible fonts?

-- 
epistemological humility
  Chris Riddoch
