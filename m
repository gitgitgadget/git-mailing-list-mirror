From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [kha/safe PATCH] completion bugfix: Place double pipes in front of alternate command.
Date: Fri, 23 Jan 2009 02:35:04 +0100
Message-ID: <20090123013504.GA24829@diana.vm.bytemark.co.uk>
References: <20090122232928.GA23456@diana.vm.bytemark.co.uk> <1232670372-20000-1-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, catalin.marinas@gmail.com
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 02:36:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQAyQ-00082L-VL
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 02:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbZAWBfS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2009 20:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756082AbZAWBfR
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 20:35:17 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4823 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756072AbZAWBfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 20:35:16 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LQAwq-0006fm-00; Fri, 23 Jan 2009 01:35:04 +0000
Content-Disposition: inline
In-Reply-To: <1232670372-20000-1-git-send-email-ted@tedpavlic.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106820>

On 2009-01-22 19:26:12 -0500, Ted Pavlic wrote:

> -            'complete -o default -F _stg stg' ] ]
> +            '|| complete -o default -F _stg stg' ] ]

Thanks, I've edited the patch and pushed it out again.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
