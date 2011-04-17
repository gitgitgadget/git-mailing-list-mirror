From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: History for Strbuf and ParseOpts?
Date: Sun, 17 Apr 2011 11:19:31 -0700 (PDT)
Message-ID: <m3wriswxku.fsf@localhost.localdomain>
References: <BANLkTimg-a-k8wR-gotEYUQ+C3LcwsBGuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 20:19:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBWZP-0008Jt-5i
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 20:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990Ab1DQSTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 14:19:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61220 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab1DQSTd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 14:19:33 -0400
Received: by fxm17 with SMTP id 17so2619456fxm.19
        for <git@vger.kernel.org>; Sun, 17 Apr 2011 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=/OTvaFo7pDSXtch+13/tXm+5mI08ulEoP3h18MJ9vQA=;
        b=pXqcdiwnO/hovTKHlG+WrhAtJF8YoagGYy8Bhq9VZFVAea9cNpAWkiFa0PBGtKTycH
         2HejWxGYoaBsIPfJk8A05oxrp8MRrS+Xnd3CH6hqZNUX4HIUOxe6XbY+LvvilFDBB/tJ
         Fv5J86GhbzKRFAHHcZHbeUr9yc+aXcXLplQkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=DPDgC0uawsPq1+aQjAf8sNJ0XejNFnWrMbCajv4Jbxs4xO6Z6wWkef7ddYcAKoLcJm
         ODzN/8XBvmU3TIcmXOmUgSGdYiFK1SBXTjUokaqX7Gs/t/jDpYeFnE4ZzFx68kwW+f0v
         5WB56ljenfiIFkCFRFmdIj3SH68XUhfNRbxC8=
Received: by 10.223.79.79 with SMTP id o15mr4239799fak.16.1303064372364;
        Sun, 17 Apr 2011 11:19:32 -0700 (PDT)
Received: from localhost.localdomain (abvn58.neoplus.adsl.tpnet.pl [83.8.211.58])
        by mx.google.com with ESMTPS id t2sm1423291faa.47.2011.04.17.11.19.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Apr 2011 11:19:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3HIIxjL003340;
	Sun, 17 Apr 2011 20:19:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3HIIg6c003330;
	Sun, 17 Apr 2011 20:18:42 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTimg-a-k8wR-gotEYUQ+C3LcwsBGuw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171725>

David Chanters <david.chanters@googlemail.com> writes:

> I shouldn't conflate to two (parseopts and strbuf) but can someone
> tell me how these two things came about -- that is, when/why/how?  If
> I understand strbuf correctly, it's a transparent and dynamic way of
> handling strings?  If so, how useful would it be as a separate
> project?

I don't have a pointers to exchange of emails that started the road to
strbuf and parseopt, but both are described in the techical
documentation (GIT API Documents):

  Documentation/techical/*
  http://www.kernel.org/pub/software/scm/git/docs/technical/api-index.html
  
  http://www.kernel.org/pub/software/scm/git/docs/technical/api-strbuf.html
  http://www.kernel.org/pub/software/scm/git/docs/technical/api-parse-options.html

-- 
Jakub Narebski
Poland
ShadeHawk on #git
