From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Git and securing a repository
Date: Wed, 2 Jan 2008 20:26:29 +1100
Message-ID: <ee77f5c20801020126n1776d625ya6928c2e4bfdf497@mail.gmail.com>
References: <477B39B5.5010107@advancedsl.com.ar>
	 <31e679430801012234x20bbebe7vb496a338bf2699d5@mail.gmail.com>
	 <477B6199.6070601@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Felipe Balbi" <felipebalbi@users.sourceforge.net>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Gonzalo_Garramu=F1o?=" <ggarra@advancedsl.com.ar>
X-From: git-owner@vger.kernel.org Wed Jan 02 10:27:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9zsP-0007dq-9W
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 10:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbYABJ0c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 04:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbYABJ0c
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 04:26:32 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:25139 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbYABJ0b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2008 04:26:31 -0500
Received: by rv-out-0910.google.com with SMTP id k20so5200644rvb.1
        for <git@vger.kernel.org>; Wed, 02 Jan 2008 01:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qTdSG7nvWY3lJX3gNUZIt/SLfWSV71RZssyBGv8vqo0=;
        b=N0kESiVVDb8XtkJctcGHmS19wcpsadEvKIRf0QrjzioXnhTHvgvBEB4VAZK8RD+uE0ngosFMcU5d7EuO4VvpYCdPIKWYYDn+a+wiH7H63/hOoAcJSvK9S0qu6iOI8sLHIKl6X1F9rH/hIgPJinhv2CFkIgF5+AxLyIcH0C6a4KI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aBS/o+a9Rqw3UWCwISaf7+iJ/GTiLpkZETJ+FmrVl7El7v0cvPUmyeXU52yGMmeJgF7HVwK5h2Ms/M4AxMcDT4BXHktnIk9xoMuytdqAn+rEXBqUc/zdeTw3IbFi5bhucvRjl5APrwbb2A5phemR1bKDHpgcbL93DrFyvPWK63o=
Received: by 10.141.206.13 with SMTP id i13mr7203788rvq.100.1199265989787;
        Wed, 02 Jan 2008 01:26:29 -0800 (PST)
Received: by 10.140.135.17 with HTTP; Wed, 2 Jan 2008 01:26:29 -0800 (PST)
In-Reply-To: <477B6199.6070601@advancedsl.com.ar>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69464>

On Jan 2, 2008 9:04 PM, Gonzalo Garramu=F1o <ggarra@advancedsl.com.ar> =
wrote:
> Felipe Balbi wrote:
> >
> > it's easy on the full repository case, create different groups and
> > share git repositories by groups, after that chmod o-rwx -R
> > /path/to/repository.git.
> >
>
> Thanks.  I'll admit what you describe is somewhat discouraging, as wh=
at
> you are just describing is just managing user accounts or groups on t=
he
> underlying OS.  That does not extend well to placing code on the net =
and
> has a bunch of administrative headaches.
>
> I was really looking for a permission based system that was part of g=
it
> itself (and thus more portable and easier to admin), and not the OS.
> Something akin to what perforce or even CVS can do.

You can do arbitrarily-fine-grained authentication via the pre-receive =
hook.


Dave.
