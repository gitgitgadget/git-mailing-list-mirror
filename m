From: E R <pc88mxer@gmail.com>
Subject: Re: odd behavior with export LESS=i
Date: Tue, 14 Jul 2009 12:28:02 -0500
Message-ID: <3a69fa7c0907141028u172fc32eg87db0364a189d94c@mail.gmail.com>
References: <3a69fa7c0907141018l4f6fb773o219b6a18effc393d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 19:35:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQlue-0004uC-HS
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 19:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbZGNRfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 13:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753230AbZGNRfF
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 13:35:05 -0400
Received: from mail-yw0-f203.google.com ([209.85.211.203]:58072 "EHLO
	mail-yw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbZGNRfE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 13:35:04 -0400
X-Greylist: delayed 970 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jul 2009 13:35:04 EDT
Received: by ywh41 with SMTP id 41so80576ywh.33
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=5xrXOhGe/yTmOvfzcoT2eB6Dh0OBGQN5QrU9zYVzUlo=;
        b=KKSUSf45roj/6eqqYXdWk9rJd5S4cvkBRBL7Enc6aLMIqFQoZmGCbeJfXA2KlOlLHh
         rIgDa8DD2vxSgBVdiyr3vlvV2nAhLnSTvHHWHOj45AaKPt7WmiyA6GOw7GtoylyitfCz
         LO0h0tlzi7Pj86+voeJFUidoC3pdu660RqoPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=dDxC7aCl9n1OoyvYsARVVle24XjtWOmQ+ETtVZc0bn4xxM2MLA99bDMTmvseBXZUW7
         a9oKEKrs1zK/Pw6FKRqmNMwTKRdmIV7DLyyXMDteeKRdrkFy6h0qtX0Oyz6tmZn28bb7
         Rn6prYQOlirbmFflQ3AO+2dg7YOc3hUATZT/0=
Received: by 10.150.124.13 with SMTP id w13mr10709011ybc.312.1247592482119; 
	Tue, 14 Jul 2009 10:28:02 -0700 (PDT)
In-Reply-To: <3a69fa7c0907141018l4f6fb773o219b6a18effc393d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123260>

Ok - I've just read the git-config man page (the section on
core.pager) which explains everything..

On Tue, Jul 14, 2009 at 12:18 PM, E R<pc88mxer@gmail.com> wrote:
> Is this a problem with less or with git?
>
> From the shell if I run:
>
> export LESS
> LESS=i git log
>
> then I see things like ESC[33m instead of colored text.
>
> If I run:
>
> unset LESS
> git log
>
> then I get colored text.
>
> Note that the environment variable LESS is used to pass default
> command line switches to less.
>
