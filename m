From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/2] apply, entry: speak of submodules instead of subprojects
Date: Tue, 16 Jul 2013 21:05:34 +0200
Message-ID: <51E5997E.2090607@web.de>
References: <87bo631odi.fsf@hexa.v.cablecom.net> <8df0d41caa10a38e46783bebd3148a7b8445dd47.1373966389.git.trast@inf.ethz.ch> <20130716180739.GK14690@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 16 21:11:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzAeZ-0004Fl-Qf
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 21:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933696Ab3GPTLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 15:11:11 -0400
Received: from mout.web.de ([212.227.17.11]:61277 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933253Ab3GPTLK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 15:11:10 -0400
Received: from [192.168.178.41] ([91.3.141.105]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0Md4le-1UiBwe2rEQ-00IG4e; Tue, 16 Jul 2013 21:05:39
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130716180739.GK14690@google.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V03:K0:NQuy9g5vRj8d3KeKTZPzA9+ujeFSteuWhjkciqjxsYBXtZAaY1G
 tXIWCmhKK0vZyhnLlGqjUuAcpyi6ey8Xfqu1WjY73zpdG0Oe3uIEDRKnTUx9Mu4DmVGNWoP
 t/NXu+M0H7fd56y5n4AsO3jg3Xj2xPOOnQDrTKDpaRPfwzUUQkW9fK40ngfio7GxfFB2XSw
 OVhepQypeD9ONVTy5h25g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230578>

Am 16.07.2013 20:07, schrieb Jonathan Nieder:
> Thomas Rast wrote:
> 
>> There are only four (with some generous rounding) instances in the
>> current source code where we speak of "subproject" instead of
>> "submodule".  They are as follows:
> [...]
>> Let's at least change the error messages to consistently call them
>> "submodule".
>>
>> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
>> ---
>> This and the next one are message changes for things I found during my
>> review.
> 
> Thanks.  It's nice when translation results in the messages in English
> being improved, too.

Obviously I like this change too. ;-)

But a 'git grep "corrupt patch for sub"' shows some files in the po
directory still containing that string on current master. Shouldn't
they be changed too or is this just a sign of me not understanding
the translation process?
