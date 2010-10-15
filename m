From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] compat: add memrchr()
Date: Fri, 15 Oct 2010 11:35:53 +0200
Message-ID: <4CB82079.4030402@viscovery.net>
References: <1287098999-9244-1-git-send-email-ydirson@altern.org> <20101015051750.GA21830@burratino> <AANLkTi=MbSeeUcPpPt_yLyeTv10pNzHqGUu3ihXf8jb+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Oct 15 11:36:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6gho-000238-3X
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 11:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab0JOJf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 05:35:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:25793 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750882Ab0JOJf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 05:35:56 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P6ghe-00015c-2L; Fri, 15 Oct 2010 11:35:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BB3291660F;
	Fri, 15 Oct 2010 11:35:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <AANLkTi=MbSeeUcPpPt_yLyeTv10pNzHqGUu3ihXf8jb+@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159109>

Am 10/15/2010 10:56, schrieb Erik Faye-Lund:
> On Fri, Oct 15, 2010 at 7:17 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Reimplement another handy convenience function from glibc.  memrchr()
>> searches from the end of a memory area for a particular character.  It
>> is similar to strrchr() but takes a length argument and is
>> binary-safe.
>>
>> The whole-directory rename detection patch could use this to find the
>> last directory separator in a (possibly truncated) pathname.
>>
> 
> Are you sure this would work on Windows where both '/' and '\' are
> valid directory separators?

I'm sure this would be used only on paths that were constructed from index
or repository contents; there, the directory separator is '/' by definition.

-- Hannes
