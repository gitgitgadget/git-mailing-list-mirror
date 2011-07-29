From: Ferry Huberts <mailings@hupie.com>
Subject: Re: gitignore design
Date: Fri, 29 Jul 2011 13:51:55 +0200
Message-ID: <4E329EDB.6040007@hupie.com>
References: <1311934832699-6632987.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: llucianf <llucianf@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 13:52:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmlbn-0005Js-Nw
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 13:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab1G2Lv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 07:51:58 -0400
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:52278 "EHLO
	mail.hupie.dyndns.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752574Ab1G2Lv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 07:51:58 -0400
Received: from stinkpad.internal.hupie.com (82-197-206-98.dsl.cambrium.nl [82.197.206.98])
	by mail.hupie.dyndns.org (Postfix) with ESMTP id 5B1FF58BD75;
	Fri, 29 Jul 2011 13:51:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <1311934832699-6632987.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178131>

On 07/29/2011 12:20 PM, llucianf wrote:
> why gitignore doesnt simply work like in cvs where if you put something in
> the ignore file, those stuff are simply ignored from that point without
> having to remove them from repo?
> 

because when it's in the repo you obviously want to track it...
tracking trumps ignoring


if you now suddenly do not want to track it anymore you have to remove
it and ignore it.


-- 
Ferry Huberts
