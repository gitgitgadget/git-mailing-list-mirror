Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465D4400
	for <git@vger.kernel.org>; Sun, 14 Jan 2024 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkWWh6F+"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78329cb6742so380090985a.0
        for <git@vger.kernel.org>; Sun, 14 Jan 2024 00:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705220165; x=1705824965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KP8AvDNfopN/86zdYVRdHQ0HyoZttAklcpdoGCikx28=;
        b=TkWWh6F+Htx0kalDd5M4d+vKdD8dRlOdu1sjKNH8i2mBU5YSI4c79LJY0gX3fNri0Z
         +LjEqvC6t06LJ08pWGD/G9uDIsP7q46+7H3JWBKMeU7Bh36nxeJe5SCh/m8SuNtTZYJs
         xRidnl/aKVqui3F/r7xWDvNYCP/MNdWIUH7DgN08peqJaAgB4ipXMRmiyZjH9CdeYbED
         CSgU977B8jw4QetdRqoJsj2VQruNG5lK57aJVLd0EcCZcWaj+07//qpt7yfEcGjoRrht
         XMRbmVme2q6/P+EYhyDhPKGj7IgIFjmmS3DBI3GobAxaJbpDIZhZlwU1wHyXPFLpQYRr
         I83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705220165; x=1705824965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KP8AvDNfopN/86zdYVRdHQ0HyoZttAklcpdoGCikx28=;
        b=eY2NlMRIy9uwMJNLnY2WuzXPYZRqbDU/DA2IL35UnzHWfMjuyq3Ymetu0syzeA2Zch
         KfVNjVRXQczS/0taqnNgI61cCpjSm53gnVBPjo+56Wde3L/8Y2Ny74VsPADdWNQAwpEu
         reKKoxX+IYyAvue3RrXDUX20YUtaBpe3ra1PcCYa8qXew52+2bmOK0IO79Yu9peJJC5R
         Lr40QAfGr8LYoKRsTViivtX6szojFRIdZDczZLMTtuKQyDz5uKrOy6Bob4tY47MLLC8o
         s7OZOcLrHFWtUqHS2qfYxEc8d6tb6AH/gKai4iI5FhWUjV5YvsMHRIPs6a6fCVxfvMjE
         0K+w==
X-Gm-Message-State: AOJu0YzuD4ySeYSAvb50B+eC1O5G7pik9SSluophyHzHLTNxIBTO2AJZ
	9BTbzshvSnru5BZGSNB3sjTH081IB/krZfAgNfiv37LD
X-Google-Smtp-Source: AGHT+IHmmhzAbaP9/uE382P+qRjTBeN3R6LMG5QTyfk9PFwzo922TQ5DDOe9Ulf9L9eWgwduaANlRViQjyj7CY3kJs8=
X-Received: by 2002:a05:620a:1a0d:b0:783:36e6:7fa2 with SMTP id
 bk13-20020a05620a1a0d00b0078336e67fa2mr4510387qkb.82.1705220165143; Sun, 14
 Jan 2024 00:16:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1642.git.1705219829965.gitgitgadget@gmail.com>
In-Reply-To: <pull.1642.git.1705219829965.gitgitgadget@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sun, 14 Jan 2024 13:45:58 +0530
Message-ID: <CA+J6zkS3zKJ5kNfCQGsi-ra31RzX9XRKT7popnhA5YrgrxVRog@mail.gmail.com>
Subject: Re: [PATCH] tests: move t0009-prio-queue.sh to the new unit testing framework
To: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Please ignore the patch above, my e-mail client seems to have
messed up the backslash indentation. I will follow up with the
corrected patch shortly.

On Sun, 14 Jan 2024 at 13:40, Chandra Pratap via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Chandra Pratap <chandrapratap3519@gmail.com>
>
> t/t0009-prio-queue.sh along with t/helper/test-prio-queue.c unit
> tests Git's implementation of a priority queue. Migrate the
> test over to the new unit testing framework to simplify debugging
> and reduce test run-time. Refactor the required logic and add
> a new test case in addition to porting over the original ones in
> shell.
>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>     tests: move t0009-prio-queue.sh to the new unit testing framework
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1642%2FChand-ra%2Fprio-queue-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1642/Chand-ra/prio-queue-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1642
>
>  Makefile                    |  2 +-
>  t/helper/test-prio-queue.c  | 51 -------------------
>  t/helper/test-tool.c        |  1 -
>  t/helper/test-tool.h        |  1 -
>  t/t0009-prio-queue.sh       | 66 -------------------------
>  t/unit-tests/t-prio-queue.c | 99 +++++++++++++++++++++++++++++++++++++
>  6 files changed, 100 insertions(+), 120 deletions(-)
>  delete mode 100644 t/helper/test-prio-queue.c
>  delete mode 100755 t/t0009-prio-queue.sh
>  create mode 100644 t/unit-tests/t-prio-queue.c
>
> diff --git a/Makefile b/Makefile
> index 312d95084c1..d5e48e656b3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -828,7 +828,6 @@ TEST_BUILTINS_OBJS += test-partial-clone.o
>  TEST_BUILTINS_OBJS += test-path-utils.o
>  TEST_BUILTINS_OBJS += test-pcre2-config.o
>  TEST_BUILTINS_OBJS += test-pkt-line.o
> -TEST_BUILTINS_OBJS += test-prio-queue.o
>  TEST_BUILTINS_OBJS += test-proc-receive.o
>  TEST_BUILTINS_OBJS += test-progress.o
>  TEST_BUILTINS_OBJS += test-reach.o
> @@ -1340,6 +1339,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
>
>  UNIT_TEST_PROGRAMS += t-basic
>  UNIT_TEST_PROGRAMS += t-strbuf
> +UNIT_TEST_PROGRAMS += t-prio-queue
>  UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
>  UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
>  UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
> diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
> deleted file mode 100644
> index f0bf255f5f0..00000000000
> --- a/t/helper/test-prio-queue.c
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -#include "test-tool.h"
> -#include "prio-queue.h"
> -
> -static int intcmp(const void *va, const void *vb, void *data UNUSED)
> -{
> -       const int *a = va, *b = vb;
> -       return *a - *b;
> -}
> -
> -static void show(int *v)
> -{
> -       if (!v)
> -               printf("NULL\n");
> -       else
> -               printf("%d\n", *v);
> -       free(v);
> -}
> -
> -int cmd__prio_queue(int argc UNUSED, const char **argv)
> -{
> -       struct prio_queue pq = { intcmp };
> -
> -       while (*++argv) {
> -               if (!strcmp(*argv, "get")) {
> -                       void *peek = prio_queue_peek(&pq);
> -                       void *get = prio_queue_get(&pq);
> -                       if (peek != get)
> -                               BUG("peek and get results do not match");
> -                       show(get);
> -               } else if (!strcmp(*argv, "dump")) {
> -                       void *peek;
> -                       void *get;
> -                       while ((peek = prio_queue_peek(&pq))) {
> -                               get = prio_queue_get(&pq);
> -                               if (peek != get)
> -                                       BUG("peek and get results do not match");
> -                               show(get);
> -                       }
> -               } else if (!strcmp(*argv, "stack")) {
> -                       pq.compare = NULL;
> -               } else {
> -                       int *v = xmalloc(sizeof(*v));
> -                       *v = atoi(*argv);
> -                       prio_queue_put(&pq, v);
> -               }
> -       }
> -
> -       clear_prio_queue(&pq);
> -
> -       return 0;
> -}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 876cd2dc313..5f591b9718f 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -57,7 +57,6 @@ static struct test_cmd cmds[] = {
>         { "path-utils", cmd__path_utils },
>         { "pcre2-config", cmd__pcre2_config },
>         { "pkt-line", cmd__pkt_line },
> -       { "prio-queue", cmd__prio_queue },
>         { "proc-receive", cmd__proc_receive },
>         { "progress", cmd__progress },
>         { "reach", cmd__reach },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index 70dd4eba119..b921138d8ec 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -50,7 +50,6 @@ int cmd__partial_clone(int argc, const char **argv);
>  int cmd__path_utils(int argc, const char **argv);
>  int cmd__pcre2_config(int argc, const char **argv);
>  int cmd__pkt_line(int argc, const char **argv);
> -int cmd__prio_queue(int argc, const char **argv);
>  int cmd__proc_receive(int argc, const char **argv);
>  int cmd__progress(int argc, const char **argv);
>  int cmd__reach(int argc, const char **argv);
> diff --git a/t/t0009-prio-queue.sh b/t/t0009-prio-queue.sh
> deleted file mode 100755
> index eea99107a48..00000000000
> --- a/t/t0009-prio-queue.sh
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -#!/bin/sh
> -
> -test_description='basic tests for priority queue implementation'
> -
> -TEST_PASSES_SANITIZE_LEAK=true
> -. ./test-lib.sh
> -
> -cat >expect <<'EOF'
> -1
> -2
> -3
> -4
> -5
> -5
> -6
> -7
> -8
> -9
> -10
> -EOF
> -test_expect_success 'basic ordering' '
> -       test-tool prio-queue 2 6 3 10 9 5 7 4 5 8 1 dump >actual &&
> -       test_cmp expect actual
> -'
> -
> -cat >expect <<'EOF'
> -2
> -3
> -4
> -1
> -5
> -6
> -EOF
> -test_expect_success 'mixed put and get' '
> -       test-tool prio-queue 6 2 4 get 5 3 get get 1 dump >actual &&
> -       test_cmp expect actual
> -'
> -
> -cat >expect <<'EOF'
> -1
> -2
> -NULL
> -1
> -2
> -NULL
> -EOF
> -test_expect_success 'notice empty queue' '
> -       test-tool prio-queue 1 2 get get get 1 2 get get get >actual &&
> -       test_cmp expect actual
> -'
> -
> -cat >expect <<'EOF'
> -3
> -2
> -6
> -4
> -5
> -1
> -8
> -EOF
> -test_expect_success 'stack order' '
> -       test-tool prio-queue stack 8 1 5 4 6 2 3 dump >actual &&
> -       test_cmp expect actual
> -'
> -
> -test_done
> diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
> new file mode 100644
> index 00000000000..98a69790f7e
> --- /dev/null
> +++ b/t/unit-tests/t-prio-queue.c
> @@ -0,0 +1,99 @@
> +#include "test-lib.h"
> +#include "prio-queue.h"
> +
> +static int intcmp(const void *va, const void *vb, void *data UNUSED)
> +{
> +       const int *a = va, *b = vb;
> +       return *a - *b;
> +}
> +
> +static int show(int *v)
> +{
> +       int ret = -1;
> +       if (v)
> +               ret = *v;
> +       free(v);
> +       return ret;
> +}
> +
> +static int test_prio_queue(const char **input, int *result)
> +{
> +       struct prio_queue pq = { intcmp };
> +       int i = 0;
> +
> +       while (*input) {
> +               if (!strcmp(*input, "get")) {
> +                       void *peek = prio_queue_peek(&pq);
> +                       void *get = prio_queue_get(&pq);
> +                       if (peek != get)
> +                               BUG("peek and get results do not match");
> +                       result[i++] = show(get);
> +               } else if (!strcmp(*input, "dump")) {
> +                       void *peek;
> +                       void *get;
> +                       while ((peek = prio_queue_peek(&pq))) {
> +                               get = prio_queue_get(&pq);
> +                               if (peek != get)
> +                                       BUG("peek and get results do not match");
> +                               result[i++] = show(get);
> +                       }
> +               } else if (!strcmp(*input, "stack")) {
> +                       pq.compare = NULL;
> +               } else if (!strcmp(*input, "reverse")) {
> +                       prio_queue_reverse(&pq);
> +               } else {
> +                       int *v = xmalloc(sizeof(*v));
> +                       *v = atoi(*input);
> +                       prio_queue_put(&pq, v);
> +               }
> +               input++;
> +       }
> +
> +       clear_prio_queue(&pq);
> +
> +       return 0;
> +}
> +
> +#define INPUT_SIZE 6
> +
> +#define BASIC_INPUT "1", "2", "3", "4", "5", "5", "dump"
> +#define BASIC_EXPECTED 1, 2, 3, 4, 5, 5
> +
> +#define MIXED_PUT_GET_INPUT "6", "2", "4", "get", "5", "3", "get", "get", "1", "dump"
> +#define MIXED_PUT_GET_EXPECTED 2, 3, 4, 1, 5, 6
> +
> +#define EMPTY_QUEUE_INPUT "1", "2", "get", "get", "get", "1", "2", "get", "get", "get"
> +#define EMPTY_QUEUE_EXPECTED 1, 2, -1, 1, 2, -1
> +
> +#define STACK_INPUT "stack", "1", "5", "4", "6", "2", "3", "dump"
> +#define STACK_EXPECTED 3, 2, 6, 4, 5, 1
> +
> +#define REVERSE_STACK_INPUT "stack", "1", "2", "3", "4", "5", "6", "reverse", "dump"
> +#define REVERSE_STACK_EXPECTED 1, 2, 3, 4, 5, 6
> +
> +#define TEST_INPUT(INPUT, EXPECTED, name)              \
> +  static void test_##name(void)                                        \
> +{                                                                                      \
> +       const char *input[] = {INPUT};                                          \
> +       int expected[] = {EXPECTED};                                    \
> +       int result[INPUT_SIZE];                                                         \
> +       test_prio_queue(input, result);                                         \
> +       check(!memcmp(expected, result, sizeof(expected)));     \
> +}
> +
> +TEST_INPUT(BASIC_INPUT, BASIC_EXPECTED, basic)
> +TEST_INPUT(MIXED_PUT_GET_INPUT, MIXED_PUT_GET_EXPECTED, mixed)
> +TEST_INPUT(EMPTY_QUEUE_INPUT, EMPTY_QUEUE_EXPECTED, empty)
> +TEST_INPUT(STACK_INPUT, STACK_EXPECTED, stack)
> +TEST_INPUT(REVERSE_STACK_INPUT, REVERSE_STACK_EXPECTED, reverse)
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +       TEST(test_basic(), "prio-queue works for basic input");
> +       TEST(test_mixed(), "prio-queue works for mixed put & get commands");
> +       TEST(test_empty(), "prio-queue works when queue is empty");
> +       TEST(test_stack(), "prio-queue works when used as a LIFO stack");
> +       TEST(test_reverse(), "prio-queue works when LIFO stack is reversed");
> +
> +       return test_done();
> +}
>
> base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
> --
> gitgitgadget
