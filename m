From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jul 2015, #03; Fri, 10)
Date: Sat, 11 Jul 2015 10:45:44 +0200
Organization: gmx
Message-ID: <b7df3f32811a3e729c9ffda3729f4707@www.dscho.org>
References: <xmqqh9pbk4y5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 10:46:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDqQ8-0002FC-If
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 10:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbbGKIpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 04:45:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:52397 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016AbbGKIpv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 04:45:51 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MV6EP-1ZUZPD39IL-00YQcI; Sat, 11 Jul 2015 10:45:46
 +0200
In-Reply-To: <xmqqh9pbk4y5.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:sJu9nv7jDSTxjORPoHfD4sebr8U44Mk03oL/bw/QZ/FY7VNcURT
 18dydtMiw/QbWYBAveGRerFsm/4sidBCFpRSFU8bCMLMdHCuOxJZ9/gzBZHRZahdE/WO5Cw
 pLsn2uw23a22AEvQVbCCL3iCjujuuleP5wZ/eIFq6Q3uFFAHUbf3ANWloNL6ITAaRrKu7sZ
 aL1jIvXF6KE8fbrVr+a4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NU3VQ8FcOqM=:HaI2Ov8HaKg08gmkvR18pi
 oClnIZFGkxsCoRV4G+YAAmYX4YUOzB9XWsHtLfRs1wA4QyXppGiK/XG7ribfgZuU5O9WadCtJ
 9guf1f+CUhJEyNNvAT8obgdlFf7jxj5NPAQwkLjcoK6G8e3IKBOV6HgTZjhlXtPoc1b3gRc+O
 O8v1zZ9rUJeuT43aTfoP8DcqVENSSIjGEOjsAhLBgRJkQDmAaPfd9aUyacssiE7ep3wW5n/Au
 O/gN1JHhiHy5nXogohJlHMQi2qT6OyExfMAMpLDpIkk3FDZ9hg7T2uyhxM8iAIcM0EbF7bPUz
 c8C/jQvE7DkPEHu916bSWpObZDc+/o/db775/6RV3wVFWJeyQTk0MXeME67CzHVrweySSXwpT
 ojo0z/nBxGZfzKHr6h4cU2cUhZsbZMOnn9MEDmcOndTuBiBEsEHkoeSqWqa6G7prvxDa+IRfP
 Egnp8G1SM+hE5b7e3KiAmYeLjOV4z8kk9uC4Tb+n9+7OLUF74eSG93wosEAn+n03EhLS28ce/
 aO9Qg1vzLCyBevUmTPEhYWBAhG0y0rfAmD18pQNb0MjOlvtU9KvdZQjq6FijQ+hGl8tjMpNV+
 sgBTojSYSYpoFV7hOBXFB87txekXZPaEaBfnf1t5LpmzQQpe/eKHY1sHVpXJgfaCzV73jCgH1
 uI6jQ6da75FMZ+eOGIhog8yxItWbCDrU9JMJQn2KsZZMtTnefXqI/UqXwuIRsKg8cbwM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273869>

Hi Junio,

On 2015-07-11 00:45, Junio C Hamano wrote:

> * et/http-proxyauth (2015-06-29) 1 commit
>   (merged to 'next' on 2015-07-09 at cf80874)
>  + http: always use any proxy auth method available
> 
>  We used to ask libCURL to use the most secure authentication method
>  available when talking to an HTTP proxy only when we were told to
>  talk to one via configuration variables.  We now ask libCURL to
>  always use the most secure authentication method, because the user
>  can tell libCURL to use an HTTP proxy via an environment variable
>  without using configuration variables.
> 
>  An extra set of eyes appreciated, but I think this is ready.

I believe so, yes, and I further believe that this would also have helped a Git for Windows user: https://github.com/git-for-windows/git/issues/234

Therefore, I am very much in favor of merging this to 'master'.

> * jc/fsck-retire-require-eoh (2015-06-28) 1 commit
>   (merged to 'next' on 2015-07-09 at dbc292b)
>  + fsck: it is OK for a tag and a commit to lack the body
> 
>  A fix to a minor regression to "git fsck" in v2.2 era that started
>  complaining about a body-less tag object when it lacks a separator
>  empty line after its header to separate it with a non-existent body.

Thanks for cleaning up after me!

> * pt/pull-builtin (2015-06-18) 19 commits
>   (merged to 'next' on 2015-07-10 at 07b1794)
>  + pull: remove redirection to git-pull.sh
>  + pull --rebase: error on no merge candidate cases
>  + pull --rebase: exit early when the working directory is dirty
>  + pull: configure --rebase via branch.<name>.rebase or pull.rebase
>  + pull: teach git pull about --rebase
>  + pull: set reflog message
>  + pull: implement pulling into an unborn branch
>  + pull: fast-forward working tree if head is updated
>  + pull: check if in unresolved merge state
>  + pull: support pull.ff config
>  + pull: error on no merge candidates
>  + pull: pass git-fetch's options to git-fetch
>  + pull: pass git-merge's options to git-merge
>  + pull: pass verbosity, --progress flags to fetch and merge
>  + pull: implement fetch + merge
>  + pull: implement skeletal builtin pull
>  + argv-array: implement argv_array_pushv()
>  + parse-options-cb: implement parse_opt_passthru_argv()
>  + parse-options-cb: implement parse_opt_passthru()
>  (this branch is used by pt/am-builtin.)
> 
>  Reimplement 'git pull' in C.
> 
>  Will merge to 'master'.

Yeah!

Ciao,
Dscho
