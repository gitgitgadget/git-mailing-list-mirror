From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Thu, 15 Oct 2015 12:50:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1510151247550.31610@s15462909.onlinehome-server.info>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com> <1444586102-82557-2-git-send-email-larsxschneider@gmail.com> <561CDDBA.609@gmail.com> <14146E1E-857D-416B-9287-F20826DCB806@gmail.com> <vpqwpuo35zo.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Schneider <larsxschneider@gmail.com>,
	=?ISO-8859-15?Q?Jean-No=EBl_Avila?= <avila.jn@gmail.com>,
	git@vger.kernel.org, tboegi@web.de, pw@padd.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 15 12:50:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmg7S-0006yn-JO
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 12:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbbJOKum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 06:50:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:57344 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522AbbJOKul (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 06:50:41 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0Lo2EO-1aFAEo0wB6-00fwXE;
 Thu, 15 Oct 2015 12:50:38 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <vpqwpuo35zo.fsf@grenoble-inp.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:I4jD31dyHELAkAYz3TJk0rn8UxkEeCSgWaguepiKIdmVX4Qpk2Y
 JUxWglCeMxSSIRzFKMq1KmRjCcq3OA0rhRQKBgBUHEPlV02QZqKKo3zySLHsnTb7I+ufOKB
 AzaFmexB9E5Y0PjK2NL2oE4iEEgj+/SsgrKshmbEla9JnTJfemGRBTsC5btc6/Xh8+ZJlMW
 yWWXAnZMWWmq8b97MqPDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GT0S/oQHf8Y=:BFbSpxHXNjUHVCUZVJLZSJ
 5zYDy0x05uxEuoNjxURDhOKFq8GgWXVk9HLhOH7DF1EW34jxRRuNI2pUYDrPcaOOTSPVXbCol
 ceVTFNWZ6wNvt1KtAzoKJtB9z6fY5q02ylitbVy+dUAo9FznCuu8tS2JSGxIZbdMgtNQYsQ/V
 db87LerDG4Uk+KuvLGf7tCOrO68BBrPNzS+2lfVTAG7vROjan7CV1CijMrzxmTEhv8rha77eY
 ub56r3/Qu/vTaIASGkUteHyebu9Sr5rAZUmkDenKvQMouw1K/pfg9DGRK05Nwh6v9Zl6BR9XA
 0otdS2yLZCLEU+vPHHQCgmIMODw4dN8Hclzyw0M1B+AhcQtAoLmvPhagoX9emwQDXXTWo+tjK
 zJBm4lmtIsG8O0Am21YvQz0uJIW+OwaWaI52hKJZq32EopJ95w4CKQwPWrSlNnqA97zV5cMel
 3x49+SZ+b0QgAURWiSg7o0kZrY4CaFJJ3q+Ca+sMAwSdC7bSyyn9s3/vzq/WBYk91LgabsQ6K
 1vkqVUyLpDWaiHIZiv+9tSEtX5Hb4m+NDAGCYiKjHoran2Sa0Go36sbi26wEG8MrPaAXGWBcf
 c5CcVomcELYQt5jRMx7OhcU9Qk2xpEbaej1Ec3XoRoDMigRYfvrKOEauryTVNNZGChmFnpehe
 /iI0RiVS2Vz7BC2+FbmBmYXlpBCNz0CaLcddCEvmQNvYFIinfaMO3FPHahmUxVh3xZzR/HhHa
 YBTr55/IuoKZrjKOJLOAvtp5eabbPQFMd9nUNlmtdnkPO27LB3bLU4pJiL9RWHBgwLU7zTbQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279660>

Hi,

On Thu, 15 Oct 2015, Matthieu Moy wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
> > I was reluctant to this because I feared problems. Especially while
> > running tests in parallel.
> 
> Isn't the point of using a CI tool to notice problems? ;-)
> 
> More seriously, running tests in parallel shouldn't be a problem since
> each test runs in its own directory with HOME set to this private
> directory, so two diffent tests should not interfer. If there's an issue
> with parallel tests, we probably prefer discovering them than avoiding
> them.

I vividly remember pulling my hair out over BuildHive (i.e. the Java-based
Jenkins alternative to Travis) failures that turned out to be
resource-related: I simply overloaded the BuildHive node.

So I assumed that the problems Lars referred to would not be problems of
Git, or the test suite, but of overwhelming a free service with an
unreasonable load.

> > make -j2 9min 11sec:
> > https://travis-ci.org/larsxschneider/git/jobs/85478022
> >
> > make 17min 20sec:
> > https://travis-ci.org/larsxschneider/git/jobs/85432398
> 
> Since the tests are essentially IO-bound and not CPU-bound, it may even
> make sense to use -j3 here.

I would like to caution against overloading Travis. They are really nice
to us, we should try to be nice to them, too.

Ciao,
Dscho
