From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] status: store format option as an int
Date: Sat, 16 Apr 2011 01:28:20 -0500
Message-ID: <20110416062727.GA15933@elie>
References: <BANLkTimKO7ihPpJ80Ad1kbYaMv1ycu0y9A@mail.gmail.com>
 <20110416000918.GB9334@sigill.intra.peff.net>
 <20110416004544.GA5628@elie>
 <20110416013723.GA23105@sigill.intra.peff.net>
 <20110416052704.GA10807@elie>
 <20110416052959.GB10807@elie>
 <7vy63abu3i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Jacek Masiulaniec <jacekm@dobremiasto.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 08:28:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAyzh-0005xW-VF
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 08:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358Ab1DPG23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 02:28:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44962 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab1DPG22 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 02:28:28 -0400
Received: by iwn34 with SMTP id 34so2649600iwn.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 23:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9BDTCLKA9iK/FdMMg/Z0a5h9ZBNJGhBY15uDiUSiSQ8=;
        b=BqDUkrIgLwZEIyU7nAHJbO/xtB9kM4QBBEhHHFtm+aXwATnDKzpYaWd3tDnIO5Wz2h
         PPXWUOxOsX9Ek8QbpwSUob9ra3eyaX/7b5+XtA8gOqEHS9Y5E8CERS6Xb7dAHS/ByOnV
         9yp5nqGi1t2JMXYobWdT/oIxExmJinWlQC+Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JIWbYcatHVuW5Yr+2TcpAeDrdlyK2E1XyEw6w4OOVO0Gj0pWbxySiB4R7d8jmth29Z
         kMbGV78ETXHQvXsc+V6nWz+kJp98LtinGBlxq52T8BEjyILQ6YE0TjKdErf+BImxlzDf
         DvusU4I/u79WTRSW1WAEXYm4pnMe27pX+Wp+g=
Received: by 10.42.174.71 with SMTP id u7mr3148998icz.123.1302935307928;
        Fri, 15 Apr 2011 23:28:27 -0700 (PDT)
Received: from elie (adsl-69-209-51-5.dsl.chcgil.sbcglobal.net [69.209.51.5])
        by mx.google.com with ESMTPS id 13sm1955576ibo.25.2011.04.15.23.28.25
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 23:28:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vy63abu3i.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171663>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Jonathan Nieder wrote:

>> Agh, proofreading fail.  For the confused, this is supposed to read as
>> "(as v1.7.0-rc0~137^2~14, status: refactor format option parsing,
>> 2009-09-05) does".
>
> Still ECANTPARSE.  Perhaps the "does" at the end should be inside the same
> parentheses pair as "as v1.7.0-..."?

Yes.  Sorry for the noise.
