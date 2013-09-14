From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/3] test: use unambigous leading path (/foo) for mingw
Date: Sat, 14 Sep 2013 08:52:31 +0200
Message-ID: <523407AF.9080205@web.de>
References: <cover.1379048276.git.worldhello.net@gmail.com> <6533cbb59cd4de1d616ef62898f64a5cd144a561.1379048276.git.worldhello.net@gmail.com> <xmqqtxhoijpz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>, Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 14 08:52:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKjit-0005Pg-00
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 08:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab3INGwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 02:52:36 -0400
Received: from mout.web.de ([212.227.15.3]:55180 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751836Ab3INGwf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 02:52:35 -0400
Received: from [192.168.209.26] ([217.208.218.204]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MddBI-1VZ7s43JD2-00PLK5 for <git@vger.kernel.org>;
 Sat, 14 Sep 2013 08:52:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <xmqqtxhoijpz.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:/EONK7SEnCfSpnxXoR3tEPJ0fCqA+A6VDQ8lGy6w488WYNOm445
 CcqvVkSh8fdykBksMgOm/vJfx/tYQdvDXScaPzieSFDw8qPFcV3ecGtQ6kJYjPz5Vep+og0
 ajPS3K9dkTukDlv/80vBKFUconCqsCm1InFJefEdocZA3+pl53z9lUidbY9YMORdKDhjM/f
 ebKU/cCoI0VQMiLU4uC3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234802>

On 2013-09-13 21.51, Junio C Hamano wrote:
> Jiang Xin <worldhello.net@gmail.com> writes:
> 
>> In test cases for relative_path, path with one leading character
>> (such as /a, /x) may be recogonized as "a:/" or "x:/" if there is
>> such doc drive on MINGW platform. Use an umambigous leading path
>> "/foo" instead.
> 
> "DOS drive", you mean?
> 
> Are they really spelled as /a or /x (not e.g. //a or something)?
> 
> Just double-checking.
Yes,
there is a directoctory structure in / like this:

/usr
/bin
/lib
Then we have the drive letters mapped to single letters:
/c/Documents and Settings
/c/temp

As an alternative
c:/temp can be used
or the DOS style
"c:\temp"

And the // or "\\" is used for the UNC names (Universal Name Convention)
//Servername/ShareName/Directory

/Torsten
