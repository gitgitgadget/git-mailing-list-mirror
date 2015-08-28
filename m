From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/9] Progress with git submodule
Date: Fri, 28 Aug 2015 12:09:02 +0200
Organization: gmx
Message-ID: <b5126a0a9438e8737c726d887ebc96e3@www.dscho.org>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
	gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 12:09:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVGbA-0001ml-Fi
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 12:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbbH1KJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 06:09:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:50826 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbbH1KJS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 06:09:18 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M3RVA-1Yeg0O22me-00r3lx; Fri, 28 Aug 2015 12:09:04
 +0200
In-Reply-To: <1440724495-708-1-git-send-email-sbeller@google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:A4WcFFhsei5foik8/FgOkfQksnc7WYhKNCBBwQauUjFeL9Ja+T0
 eRLyFvBdox2Jui616bCcW/EkFYvNhG210bZIXvTDL5qu35OKEs9KtPtUIpOO1h5TnWOdXay
 wGFUF+AhNlCWzShMwcmBwwenjF0Q9UH9uiVyzlb1xvLQaLNoazc46XrojidOk2uj4AH3PUi
 D/8klqInbYUwidyx6cPWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hugCrbkiTRQ=:yW3UAh30vmovUkQ1Tim5Hh
 lPqd5OQkCAOmoOiPhN8JPOWpvLUz4sjlEwAOlhOx+vJk4laI+EISWPTxeozOrTyyl+cb050uO
 tvYoziTNvNSwXUHIEjlGxu9Xq/JkJUSurR4qYHRGBOIo1J4BYu8eyFinP/4yXw9YWtEXFDlnN
 eHDT7hfw1rSat5oUDNieHE8jRKhy0aTxiPR5ZNTMcg6axOV8hmBIH7npI/OkBIDTRIP0EYeCZ
 fugAI6isUVVCQsu+OVEPLRe3xxrbj7KZsBFiYRyiaNnfIHzWS7WvNzGp9Q4bFDrNt/n56CS3G
 q690EvnunLdMzlzAVxG4WBN143LqxoOBGpa4AlZnGcAGsciHnAVsZkGcO8YBeGd0xkNLi1Drh
 JJbsxVQyTVRc3HP0gEXylna6PzowDzupK90024QwVjUdrqHUWNqI7s7x9HxxDjtbYOWh2S7RO
 kfNCdbNrQuwxkBghKwOjBV47L4a4QbdU3XLn1vDRwzdDrCacbPbYtrgh+WlWidFFNb1U1zEDB
 aqRWdZfIqD8OzFKfSZ+c3Lo0nwoRa8ICo3C3eV944tLtH1YIBhIflwtaasDWhv6DJ7qdr/RiB
 Y8MUfe3gbFKF2aq7lGTBkmZ5mKjJUzOLeJUJ3KMglYZKqJ5YNeftM7lA+npyJ3fWyh8DbhgEn
 kpfr0DdwnrUe5Y9N709/j3oWvvA0sqovzE+odVXOoSNqagceH0nSJFbK7kUAUdARVJlbFjFpU
 bZ1KtqdjHhwqnlvriyU8Wv6pJ/eGtk00+HL3MQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276714>

Hi Stefan,

On 2015-08-28 03:14, Stefan Beller wrote:

> Stefan Beller (9):
>   submodule: implement `module_list` as a builtin helper
>   submodule: implement `module_name` as a builtin helper
>   submodule: implement `module_clone` as a builtin helper

Another thing that just hit me: is there any specific reason why the underscore? I think we prefer dashes for subcommands (think: cherry-pick) and maybe we want to do the same for subsubcommands...

Ciao,
Dscho
