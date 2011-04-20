From: Joe Perches <joe@perches.com>
Subject: Re: [RFC PATCH] git-send-email: Validate recipient_cmd (to-cmd,
 cc-cmd) addresses
Date: Wed, 20 Apr 2011 16:01:17 -0700
Message-ID: <1303340477.24766.43.camel@Joe-Laptop>
References: <BANLkTikdaSG_jbzaJ7UCpG5JnwneARfx3Q@mail.gmail.com>
	 <20110419215239.GA22632@elie> <1303268630.24766.9.camel@Joe-Laptop>
	 <BANLkTinfbF3xyfrdgfmgHQF7RHCHk8ardw@mail.gmail.com>
	 <1303336253.24766.34.camel@Joe-Laptop>
	 <BANLkTikuC1V1U-c0wyThOZAn6gVXr7S_cQ@mail.gmail.com>
	 <1303339511.24766.41.camel@Joe-Laptop>
	 <BANLkTintK1KgPWX7ycMQtVBnKi+tVj7k2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 01:01:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCgOj-0001Vw-1I
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 01:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787Ab1DTXBT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2011 19:01:19 -0400
Received: from mail.perches.com ([173.55.12.10]:4859 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413Ab1DTXBT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 19:01:19 -0400
Received: from [192.168.1.162] (unknown [192.168.1.162])
	by mail.perches.com (Postfix) with ESMTP id A55FA24368;
	Wed, 20 Apr 2011 16:01:14 -0700 (PDT)
In-Reply-To: <BANLkTintK1KgPWX7ycMQtVBnKi+tVj7k2Q@mail.gmail.com>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171880>

On Thu, 2011-04-21 at 00:50 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on wrote:
> On Thu, Apr 21, 2011 at 00:45, Joe Perches <joe@perches.com> wrote:
> > On Thu, 2011-04-21 at 00:29 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bja=
rmason wrote:
> >> On Wed, Apr 20, 2011 at 23:50, Joe Perches <joe@perches.com> wrote=
:
> >> > +       my ($recipient_name, $recipient_addr) =3D ($recipient =3D=
~ /^\s*(.*?)\s*(<[^>]+>)/);
> >> In Perl you can write (<.*?>) instead of (<[^>]+>)
> > Hey =C3=86var.  That matches <>.  Not a good email address.
> True, but you can use <.+?> instead.

Nope, that matches all of "<>>"
I want to terminate the match on the first >.
