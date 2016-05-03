From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 08/11] connect: change the --diag-url output to
 separate user and host
Date: Tue, 3 May 2016 18:20:01 +0200
Message-ID: <c1cc0220-d239-1589-9957-1ef8a6245d54@web.de>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462265452-32360-1-git-send-email-mh@glandium.org>
 <1462265452-32360-9-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, tboegi@web.de
To: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 18:20:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axd3f-0000ay-W8
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 18:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933642AbcECQUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 12:20:20 -0400
Received: from mout.web.de ([212.227.15.3]:64931 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933433AbcECQUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 12:20:19 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0Lkm1c-1bXmgZ0xls-00aSOf; Tue, 03 May 2016 18:20:03
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <1462265452-32360-9-git-send-email-mh@glandium.org>
X-Provags-ID: V03:K0:7jBsb4GkbvUiDjehT9ngOQkIxw+aWkGVqkItYBK/5U7IQWhOnFk
 KGmOpqCChnmEJvP8RqNyPHjWbqgeOok/c5OpKJ8pN8Udcy9S2DkcbyG//aqD0ck6xsK9JMh
 rUS/NPYnrDfwUjoW3gsADWD3scthcOz2c4Zl/haq2D0fX6n90VcPGYGS1dcmr/8tPdQIc/L
 dzRI09GvQv62WynsVXLow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3TbnDHj0DI0=:QsQ1qoDAcB0eh33KGEAjJk
 dJ5PpiG3b8Q6xBl5WAiVMHUag3/EhqNl1FdCFsPjN91t+zJ61viA1gddmi2v+gzd2RmNL/SA1
 6j9djtGfuoAfCf86XxaNgP6sAUimVU5XN/GvsWL92Qk57t23QRmAFJP2YJUq1JUtWXEbb506p
 jsHVDjESjXt/Doks1qKzXPFWOdjx75BLDM9vVQoYl99eWe+sPO96UeIo1HMqsuAIuMx2/4YsS
 NMjor6t+XNqWM9exAiBV8GlZ1jH+qgvD7+y96BLPOuFkGmobxWP5YmlQXsAixt/dte5Pjhkbn
 s+vSLlAEV8KojnIoDF9cwkWx3bCYNuEep8zzakvL8ejLMjIhU3rmIRp6nDY86ll1KrT/GhW1O
 B/4ZkSdiO+nzPaHsxyHe/UjxlDgypvvP5JwirpvmlG3Ku3A2WC2N0FyoAVReZQ2w37NDKXnGH
 W55dEV/qjRGha6hSy5S8QgtLuUjHbK340s9SPAXSXOfdE+EgNKWjxioz7vdQBDLSI25QpHh6i
 x501J0I88odYsrEANWtNJl3zfa7cxnERUSRDH1yneVlpQ/QNMYbDRRGUnkCB9WSqgC0HUb7E4
 zES+ziIhCvZY3/6QCz/4rAgn/MAHWIXIXP1Fpjj5Rz9CncHofGZjWovGgSztyd3jNE2VEEgH2
 QYu7gSmDFs/jIi23N7pXBVYlXqmXjxObshTFONuZIEhuyW0wlqG6ixDNTCGbx5rb63fg4R02M
 9GuD2ru9SrkNjdIJeBQZJEumZee2QF2eS5Mdmix0qR8Suli7jcpRFmeh232vH2aVkmk/ZrOT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293412>

On 2016-05-03 10.50, Mike Hommey wrote:
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  connect.c             |  6 ++----
>  t/t5500-fetch-pack.sh | 14 ++++++++++++--
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/connect.c b/connect.c
> index e95e385..2c5b722 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -703,10 +703,8 @@ struct child_process *git_connect(int fd[2], const char *url,
>  	if (flags & CONNECT_DIAG_URL) {
>  		printf("Diag: url=%s\n", url ? url : "NULL");
>  		printf("Diag: protocol=%s\n", prot_name(protocol));
> -		if (user)
> -			printf("Diag: userandhost=%s@%s\n", user, host);
> -		else
> -			printf("Diag: userandhost=%s\n", host ? host : "NULL");
> +		printf("Diag: user=%s\n", user ? user : "NULL");
> +		printf("Diag: host=%s\n", host ? host : "NULL");
>  		printf("Diag: port=%s\n", port ? port : "NONE");
>  		printf("Diag: path=%s\n", path ? path : "NULL");
>  		conn = NULL;
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 09d46c3..0c2f79f 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -537,7 +537,7 @@ check_prot_path () {
>  	Diag: protocol=$2
>  	Diag: path=$3
>  	EOF
> -	git fetch-pack --diag-url "$1" | grep -v host= | grep -v port= >actual &&
> +	git fetch-pack --diag-url "$1" | grep -v user= | grep -v host= | grep -v port= >actual &&
Running grep a couple of times is probably not optimal in terms of spawning a
process....
Does

git fetch-pack --diag-url "$1" | egrep -v "user=|host=|port=" >actual &&
work ?
or the version like this:
git fetch-pack --diag-url "$1" | egrep -v "(user|host|port)=" >actual &&


(And before I forget it: The whole series makes sense, thanks for that,
it may be good if I review the final result as well as all the small changes)
