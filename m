From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/2] send-email: add series-cc-cmd option
Date: Mon, 12 Nov 2012 15:40:36 -0800
Message-ID: <1352763636.18715.28.camel@joe-AO722>
References: <1352653463-1923-1-git-send-email-felipe.contreras@gmail.com>
	 <1352653463-1923-3-git-send-email-felipe.contreras@gmail.com>
	 <CALkWK0mRKznNN7750h=k6aE3OJ7hBLVC-G51gEYi2+NuYjPWrQ@mail.gmail.com>
	 <1352760759.18715.7.camel@joe-AO722>
	 <CAMP44s0B42yt8eugYSjYweoX8WOXXF1f-0N-5FuUyrY5rgCiow@mail.gmail.com>
	 <1352761982.18715.20.camel@joe-AO722>
	 <CAMP44s2EyMcYHYGvxZnj90qD5ms2YZ5O6gXv_TTES0H72vUm0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Pascal Obry <pascal@obry.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 00:40:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY3cX-00073y-Af
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 00:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287Ab2KLXkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 18:40:36 -0500
Received: from perches-mx.perches.com ([206.117.179.246]:36993 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754010Ab2KLXkf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 18:40:35 -0500
Received: from [173.51.221.202] (account joe@perches.com HELO [192.168.1.167])
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 19833302; Mon, 12 Nov 2012 15:40:35 -0800
In-Reply-To: <CAMP44s2EyMcYHYGvxZnj90qD5ms2YZ5O6gXv_TTES0H72vUm0g@mail.gmail.com>
X-Mailer: Evolution 3.6.0-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209548>

On Tue, 2012-11-13 at 00:37 +0100, Felipe Contreras wrote:
> On Tue, Nov 13, 2012 at 12:13 AM, Joe Perches <joe@perches.com> wrote:
> > On Tue, 2012-11-13 at 00:03 +0100, Felipe Contreras wrote:
[]
> >> For --to-cmd and --cc-cmd? So basically you check the dirname of the
> >> argument passed?
> >
> > yes. basename and dirname
> 
> Well, the basename is irrelevant, because you don't care witch
> particular patch is being sent, you are going to process all of them
> every time.

Well, I do different actions on cover letter patches
than other patches because for patch sets that touch
lots of files, the cc list can be _very_ long and
that can run afoul of other issues like maximum
recipient counts for various mailing lists.

cheers, Joe
