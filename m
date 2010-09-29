From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 00/18] git notes merge
Date: Wed, 29 Sep 2010 18:04:13 +0200
Message-ID: <201009291804.13404.johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net> <201009291716.52831.johan@herland.net> <AANLkTinjAoAYW2as1VfeWJ=t4MORjC9s7=eMCbYttier@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 18:05:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0z9m-0001Y1-2L
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 18:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab0I2QFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 12:05:13 -0400
Received: from smtp.opera.com ([213.236.208.81]:33595 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162Ab0I2QFM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 12:05:12 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o8TG4DWi027444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 29 Sep 2010 16:04:13 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <AANLkTinjAoAYW2as1VfeWJ=t4MORjC9s7=eMCbYttier@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157582>

On Wednesday 29 September 2010, Sverre Rabbelier wrote:
> On Wed, Sep 29, 2010 at 17:16, Johan Herland wrote:
> > Yeah, I'm torn as well. What about providing both? Or is that
> > bloat?
>
> Definitely not both, that would be confusing, and would limit us if
> we decide to add 'git merge --abort' later on.

Yeah, but for consistency's sake I don't want to name it 'git notes 
merge --abort' if there's not a corresponding 'git merge --abort'.

> >> I know that there's no 'git merge --abort', but IIRC that's for
> >> technical reasons only.
> >
> > Maybe there _should_ be a 'git merge --abort' (as a synonym to 'git
> > reset --merge')?
>
> Hmmm, I don't know if that does what the user wants, (I haven't used
> 'git reset --merge' before), but if it does, that sounds like a good
> solution.

>From git-merge(1):

"If you tried a merge which resulted in complex conflicts and want to 
start over, you can recover with git reset --merge."

AFAICS, there's no better candidate synonym for 'git merge --abort'.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
