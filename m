From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Sat, 12 Oct 2013 00:40:51 -0400
Message-ID: <5258D2D3.9030704@bbn.com>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>	<1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>	<522E3C6A.3070409@bbn.com>	<CAMP44s1OyST3S1HEdS38WPsjq6w9SekuwT4DRUgVvduATox9tw@mail.gmail.com>	<20130910022152.GA17154@sigill.intra.peff.net>	<CAMP44s1FfQ-1pAK8T1cmiZk4i17HnpvzPwuZrzHiiXSmGzbrRw@mail.gmail.com>	<vpqmwnljdmn.fsf@anie.imag.fr>	<52589027a4851_5dc4c2be742754f@nysa.mail>	<20131012005035.GA27939@sigill.intra.peff.net>	<CAMP44s2y0UZ9uS8xtG2WDD=k5pHSG+K+_WM2dj-DVaUDy4djdA@mail.gmail.com>	<20131012012515.GA1778@sigill.intra.peff.net> <CAMP44s3669E7JyEjP_ErYt7JN2eHv0mX4+p_=ZP4_LDatnw2vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>,
	Philip Oakley <philipoakley@iee.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 12 06:41:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUr0o-0002jY-22
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 06:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742Ab3JLElF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 00:41:05 -0400
Received: from smtp.bbn.com ([128.33.1.81]:11825 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705Ab3JLElE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 00:41:04 -0400
Received: from socket.bbn.com ([192.1.120.102]:43617)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VUr0Y-0006WH-0r; Sat, 12 Oct 2013 00:40:54 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id D2CE34097A
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CAMP44s3669E7JyEjP_ErYt7JN2eHv0mX4+p_=ZP4_LDatnw2vg@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235941>

On 2013-10-11 22:08, Felipe Contreras wrote:
> I'm fine with 'echo "warning: foo" >&2', but still, if you really
> cared about consistency, there would be a warn() function

So add one!  It's only one simple line:

    warning() { printf %s\\n "warning: $*" >&2; }

So much discussion for something so trivial...

-Richard
