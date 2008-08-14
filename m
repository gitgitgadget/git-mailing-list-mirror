From: Mark Struberg <struberg@yahoo.de>
Subject: Re: does anything like cvs export exist in git?
Date: Thu, 14 Aug 2008 22:31:15 +0000 (GMT)
Message-ID: <670518.86623.qm@web27804.mail.ukl.yahoo.com>
References: <20080814221148.GB10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:32:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlMk-0004oD-JW
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbYHNWbT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 18:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbYHNWbS
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:31:18 -0400
Received: from web27804.mail.ukl.yahoo.com ([217.146.182.9]:41658 "HELO
	web27804.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750822AbYHNWbR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:31:17 -0400
Received: (qmail 86813 invoked by uid 60001); 14 Aug 2008 22:31:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=N6uPW0HYhJhBQV8HOcqSMS0D0jexJGpYgYawtN88iomedMuXk+UnZ6pHIAOpExuktSyosfWZ/EGSWyNk/BOVk7OYI3G+pmwXiL6DvaBMs57BOqaLzM8MgjLkcO+LJAS42eQauGXmiMlJU0TZGBjMlL2tDsVyyg9BRppQFHkU97Q=;
Received: from [213.162.66.179] by web27804.mail.ukl.yahoo.com via HTTP; Thu, 14 Aug 2008 22:31:15 GMT
X-Mailer: YahooMailWebService/0.7.218
In-Reply-To: <20080814221148.GB10544@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92423>

Hi Petr!

basically a good idea, but git-cvsserver hast to be run as a _server_, =
so this is not an option here :(

txs anyway,
mark


--- Petr Baudis <pasky@suse.cz> schrieb am Fr, 15.8.2008:

> Von: Petr Baudis <pasky@suse.cz>
> Betreff: Re: does anything like cvs export exist in git?
> An: "Mark Struberg" <struberg@yahoo.de>
> CC: git@vger.kernel.org
> Datum: Freitag, 15. August 2008, 0:11
> Hi,
>=20
> On Thu, Aug 14, 2008 at 09:20:10PM +0000, Mark Struberg
> wrote:
> > I'm the initial author of the Apache
> maven-scm-providers-git and I need to update our SCM-Matrix.
>=20
> >=20
> > This is just for making sure I did not oversee
> anything.
> >=20
> > I didn't came across anything like 'cvs
> export' and I do not think git really needs this, since
> it doesn't pollute the working directories with lots of
> waste like CVS and SVN does.=20
> > But I just want to make sure to not build workarounds
> in our scm-provider (checkout + afterwards blasting the
> GIT_DIR) for things that do exist natively in git.
>=20
>   I'm not sure what exactly do you want, but
> couldn't you abuse
> git-cvsserver for the job?
>=20
> 				Petr "Pasky" Baudis

__________________________________________________
Do You Yahoo!?
Sie sind Spam leid? Yahoo! Mail verf=FCgt =FCber einen herausragenden S=
chutz gegen Massenmails.=20
http://mail.yahoo.com=20
