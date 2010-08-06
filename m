From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH v4 11/18] Add tests for line history browser
Date: Fri, 6 Aug 2010 13:28:47 +0800
Message-ID: <AANLkTinZPwtdon-qCWEx5L2c-LnfrjKdBA0pdGFmFQig@mail.gmail.com>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
	<1281024717-7855-12-git-send-email-struggleyb.nku@gmail.com>
	<201008052238.36892.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 06 07:29:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhFUM-00009z-8S
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 07:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933794Ab0HFF2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 01:28:51 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:65201 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756261Ab0HFF2t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 01:28:49 -0400
Received: by qwh6 with SMTP id 6so4626503qwh.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 22:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=+8dUVYdICaBbS3/D+Ug/BXAsK9+h7toDl6OJvGzTmqo=;
        b=jUcNkVhO0plo3v+Tqls82KopZ1j4qHjtJjW3Jy0a01E0Y6BrpfpSSSsLTqSzB2KXAx
         Sur6rtEdEVSQzHhIqNbN5z9Gr2l2zXowzXVE9ZQx3If8QuopTJIYwh14dTTDfYddirij
         zKcsxa5bXyomsWIF6QMqEl1LY5oSpFgzsAqFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=djbhL8S/OHyblo+4rmPImAJMVYg8rNYKZD/cLKVw+SGhpChNkAbAcEfcHKWkYfdaDl
         98XUzW2evqWtKWCgCNSifhI27WkXQ8errn0UH8frIXaNp/U3b/782DQL+dUdF55E7fdc
         rhxL3SEFSf+0q+PZHPx3vNjkp8LQBuRkyesS4=
Received: by 10.229.184.138 with SMTP id ck10mr1241632qcb.211.1281072527650; 
	Thu, 05 Aug 2010 22:28:47 -0700 (PDT)
Received: by 10.229.231.21 with HTTP; Thu, 5 Aug 2010 22:28:47 -0700 (PDT)
In-Reply-To: <201008052238.36892.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152764>

On Fri, Aug 6, 2010 at 4:38 AM, Thomas Rast <trast@student.ethz.ch> wrote:
> Bo Yang wrote:
>> t4301: for simple linear history only
>> t4302: for history containing merge
>>
>> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
>> ---
>
> Note that applying this with --whitespace=fix will make the tests
> fail, as there are diffs contained which must preserve the SP TAB
> sequence of context lines.

So, should I write the above into the commit message?

-- 
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
