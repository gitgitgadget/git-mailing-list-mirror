From: Bernt Hansen <bernt@norang.ca>
Subject: Re: how to track the history of a line in a file
Date: Tue, 06 Jan 2009 11:28:54 -0500
Organization: Norang Consulting Inc
Message-ID: <874p0c1jqx.fsf@gollum.intra.norang.ca>
References: <alpine.DEB.1.10.0901021405460.21567@asgard.lang.hm>
	<87d4f01lmt.fsf@gollum.intra.norang.ca>
	<20090106160814.GI21154@genesis.frugalware.org>
	<878wpo1k2p.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 17:30:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKEox-0007VD-Ne
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 17:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbZAFQ27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 11:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbZAFQ27
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 11:28:59 -0500
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:58458 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbZAFQ26 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 11:28:58 -0500
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1LKEnY-000IKo-EG; Tue, 06 Jan 2009 16:28:56 +0000
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id n06GSsT5006339
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 6 Jan 2009 11:28:55 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id n06GSsN9011531;
	Tue, 6 Jan 2009 11:28:54 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.3/8.14.3/Submit) id n06GSs3t011530;
	Tue, 6 Jan 2009 11:28:54 -0500
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19SDB6bzkQngfT/Vp+w5wRS
In-Reply-To: <878wpo1k2p.fsf@gollum.intra.norang.ca> (Bernt Hansen's message of "Tue\, 06 Jan 2009 11\:21\:50 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.95 http://www.acme.com/software/spfmilter/ with libspf2;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104700>

Bernt Hansen <bernt@norang.ca> writes:

> Miklos Vajna <vmiklos@frugalware.org> writes:
>
>> On Tue, Jan 06, 2009 at 10:48:10AM -0500, Bernt Hansen <bernt@norang.ca> wrote:
>>> Save the following script in ~/bin/git-rblame.sh, make it executable,
>>> and then create a global git alias for it as follows:
>>> 
>>> $ git config --global alias.rblame '!~/bin/git-rblame.sh $*'
>>
>> Given that you have ~/bin in PATH, just name the script ~/bin/git-rblame
>> and you won't even have to define an alias on each machine. ;-)
>
> Yes but I don't want to use 'git-rblame' as the command since I've
> broken my habit of using the dashed versions of commands. 'git rblame'
> just feels better to me.
>
> Now I probably should have named the script something that won't ever
> clash with possible future git commands (like my-git-rblame.sh or
> something) but since it's in my ~/bin I'll just deal with that if it
> ever happens in the future :)

Oops. That actually does do what I want.  Thanks for pointing that out
Miklos!

(sorry for replying to my own post - next time I'll try it first before
 I post :)

-Bernt
