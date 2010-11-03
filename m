From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: .gitattributes escape character?
Date: Wed, 03 Nov 2010 18:13:05 +0100
Message-ID: <4CD19821.2010103@syntevo.com>
References: <4CD15461.9070201@syntevo.com> <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 18:13:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgtg-0004R5-6y
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 18:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972Ab0KCRNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 13:13:12 -0400
Received: from syntevo.com ([85.214.39.145]:50922 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755487Ab0KCRNK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 13:13:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTPSA id AFE5A60812F
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
In-Reply-To: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160629>

>> Is there an escape character which may be used in .gitattributes to
>> escape e.g. the space-character? Could octal-escaping help here (I
>> didn't succeed)? Thanks for any hints.
> 
> You mean escape the path part in .gitattributes? Sorry, no.
> 
> I think we can teach git about path quoting though. A leading double
> quote means the path is quoted, C-style.

But this is not supposed to work already? At least, when quoting the
whole path:

"/a file" -text

git check-attr tells me 'file" is not a valid attribute'.

Marc.
