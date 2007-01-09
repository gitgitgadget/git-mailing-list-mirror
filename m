From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 0/5] gitweb: git_patchset_body fixes
Date: Tue, 9 Jan 2007 12:54:48 -0800 (PST)
Message-ID: <772754.41694.qm@web31805.mail.mud.yahoo.com>
References: <200701091127.01930.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 21:54:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Nzh-0001rz-5d
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 21:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbXAIUyu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 15:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbXAIUyu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 15:54:50 -0500
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:22092 "HELO
	web31805.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932431AbXAIUyt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jan 2007 15:54:49 -0500
Received: (qmail 41777 invoked by uid 60001); 9 Jan 2007 20:54:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=mDsB6OsEH4IEkUv9ORtqVKAD99IBKYf4xNyOwSNnKVnYcmNVWd/CaTg77JnwsOcbiKmFJvhYNFuD8FOmqxyx1yXnBRMiXpbBO/RSiDSIzjhno7mu7IzmW1LTHh05CKEGzUqjn47uMXecF06RYH4FnDzJPK8jwJhA+jSvDCUZrXg=;
X-YMail-OSG: PA6OiaAVM1lzhYfvzLPwdp6vqyxBc_Akx6xkQNiIVrwiJxOiOXR404PgTPH7RjL5n0q.OfYC.FrjeaOIDl2LosGdWAMz9FkN1IoKdYqkLErkg4t2TZjXVPOaLoV9RDzhVd6ijJbT5ds-
Received: from [64.215.88.90] by web31805.mail.mud.yahoo.com via HTTP; Tue, 09 Jan 2007 12:54:48 PST
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200701091127.01930.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36398>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Luben Tuikov wrote:
> 
> > Ok, I see that Junio has committed the fixes to "next" -- thanks!
> > That saved me time having to manually apply them.
> > 
> > Now, the results are that I see the same bug.
>  
> (The same bug = no closing div).
> 
> I'll try to reproduce this.
> 
> 
> What about the other error, 
> 
> >>> The second bug is displaying a renamed file with the
> >>> same name as the one of the preceding "patch". Saw
> >>> this one today when I pulled.
> 
> Is it corrected by those patches?

Yes, the second bug is corrected by your patches.
The first one still stands.

    Luben
